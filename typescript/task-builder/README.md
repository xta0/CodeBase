# fb-task-runner

This module provides a modular way of defining and running complex asynchronous
(`Promise` based) tasks. Its main features include:

* A declarative notation for dependencies between tasks, allowing some
  to run in parallel, while requiring strict sequencing between others.
* Various hooks to plug in cross-cutting concerns, so the business logic
  can stay clean. For example:
  * To display a VS Code alert between task A and Task B;
  * To selectively pipe logs to the VS Code terminal and/or a log-file
    (intelligently buffering to prevent interleaving lines from parallel tasks);
  * To submit a [Chronicle event](https://fburl.com/wiki/3abdercv) for each task.
  * To report progress to the UI.

The original RFC for this idea can be found here: <https://fb.quip.com/fCHNAdxykEU9>

## Concepts

A **task** represents an asynchronous unit of work. There are three types of task:

* a task **step** specifies its work using an `async` function;
* a task **graph** is a composition of other tasks in a dependency graph; and
* a task **decider** specifies custom async logic to decide which other task to run,
  and can also be used to handle exceptions from other tasks.

Each task has a **name** and is associated with a **Chronicle event**.

When running, all tasks are passed a **context** object, which can contain
functions and data necessary for task steps to do their work. Task steps can
also assign fields in that object, which is the main way for tasks in a graph
to communicate with each other.

## Usage

Here's a summary of how to use this module.

1. **Create a `TaskBuilder` instance**

    ```ts
    import {TaskBuilder} from 'fb-task-runner';
    import {Context} from './types'; // <-- your context type

    const taskBuilder = new TaskBuilder<Context>();
    ```

    This only needs to be done once.

2. **Use the builder to define build steps**

    ```ts
    const step1 = taskBuilder.step({
      name: 'step1',
      chronicleEvent: 'Step1EventName',
      logToChronicle: true,
      expectsFields: [/*...*/], // <-- context precondition
      assignsFields: [/*...*/], // <-- context postcondition
    }, async (context) => {
      // <-- code goes here
    });
    ```

    The `context` parameter above will automatically have the right TypeScript
    type. The base type `Context` is influenced by the pre/post-condition params.

    For example, let's say `Context` contains an optional field `foo?: string`.
    Then if `expectsFields` contains `'foo'`, the value `context.foo` is considered
    to be defined by the type-system (so you don't need to use something like
    `nullthrows`). Furthermore, `context.foo` is considered to be read-only unless
    `assignsFields` includes `'foo'`.

3. **Use the builder to define task graphs**

    ```ts
    const graph1 = taskBuilder.graph({
      name: 'graph1',
      chronicleEvent: 'Graph1EventName',
      expectsFields: [/*...*/],
      assignsFields: [/*...*/],
    }, [
      task1, // <-- existing task (step, graph or decider)
      task2a.runAfter(task1), // <-- task dependencies
      task2b.runAfter(task1),
      task3.runAfter(task2a, task2b),
    ]);
    ```

    This defines a diamond-shaped dependency graph, running `task1` first,
    then running `task2a` and `task2b` in parallel, then running `task3` last.

    The TypeScript typesystem cannot verify `context` typing for complex graphs
    of inter-dependent tasks. Instead, pre/post-conditions will be verified
    at the time `taskBuilder.graph(...)` is called.

    For example, if any task in the graph expects field `'foo'` to be defined,
    this needs to be guaranteed by either the graph's `expectsFields` param, or
    by the `assignsFields` param of a dependency task. If it cannot be guaranteed,
    `taskBuilder.graph(...)` will throw an exception.

4. **Use the builder to define task deciders**

    ```ts
    const decider1 = taskBuilder.decider({
      name: 'decider1',
      chronicleEvent: 'Decider1EventName',
      expectsFields: ['state', /*...*/],
      assignsFields: [/*...*/],
    }, [
      task1, // <-- existing task (step, graph or decider)
      task2,
      task3,
    ], async (context, {task1, task2, task3}) => {
      try {
        switch (context.state) {
          case 1:
            await task1(); // <-- Refer to tasks by name.
            break;
          case 2:
            await task2(); // <-- Don't pass any arguments.
            break;
          case 3:
            await task3(); // <-- Throws if task3 itself throws.
            break;
          default:
            // <-- It's possible to run no task at all.
        }
      } catch (error) {
        context.logError(error);
      }
    });
    ```

    This example defines a task which runs either `task1`, `task2` or `task3`,
    depending on some state in the `context`, and also prevents error propagation,
    which can be useful for non-critical tasks.

    Don't try to perform complex work in the task decider function itself.
    Inside it, `context` fields are read-only, and there are runtime checks to
    ensure a single sub-task is invoked at most. An error is thrown if not.

    Make sure to `await` the subtasks runner. If the decider function settles
    before the invoked subtask function does, an error is thrown.

    If any subtask in the graph has `'foo'` in `expectsFields`,
    the task decider should have it as well. This is verified by TypeScript.
    But TypeScript cannot verify `assignsFields` guarantees for custom
    logic like this. So instead, this is checked at runtime. If such a guarantee
    is not met, an exception is thrown after running this task.

5. **Run any previously defined task**

    ```ts
    const context = {/*...*/};
    await graph1.run(context);
    ```

    This will run the task(s) as expected, passing `context` to all steps
    involved.

## Cross-cutting Concerns

This module provides various hooks allowing certain cross-cutting concerns to
be addressed without polluting the business logic.

### Events (`.once('start')`, `.once('end')`)

Every task emits at least two events in its lifetime: `'start'` and `'end'`. In
both cases the current `context` object is passed along with the event, as are
some other values, such as the task's `runId` and that of its parent, if applicable.
The `'end'` event can also be passed a `duration` value (in ms) and an `error`
value, if applicable.

```ts
task.once('start', ({context}) => {
  logInfo(`Task 1 has started with foo='${context.foo}'`);
}).once('end', ({context, error}) => {
  if (error) {
    logError(`Task 1 terminated in with an error: ${error}`);
  } else {
    logInfo(`Task 1 has ended with foo='${context.foo}'`);
  }
});
```

### Progress reporting (`reportProgress`, `progressWeight`, `.on('progress')`)

Tasks can emit `'progress'` events, reporting a number between `0` and `1` to
indicate progress. Every task will at least report a `'progress'` of `0` just
after emitting `'start'`, and `1` just before emitting `'end'`, but a specific
step implementation may report values inbetween.

```ts
const task1 = taskBuilder.step({/*...*/}, async (context, {reportProgress}) => {
  //...
  reportProgress(0.5); // <-- emits a 'progress' event from task1
  //...
});
```

A task graph will report values inbetween based on the progress of its sub-tasks.
Sub-tasks can be provided with relative weights to make bigger tasks count more
heavily towards the total.

```ts
const graph1 = taskBuilder.graph({/*...*/}, [
  task1.options({progressWeight: 1}),
  task2a.options({progressWeight: 4, dependencies: [task1]}),
  task2b.options({progressWeight: 100, dependencies: [task1]}),
  task3.options({progressWeight: 20, dependencies: [task2a, task2b]}),
]);

graph1.on('progress', (progress: number) => {
  logInfo(`Graph 1 is ${progress * 100}% complete...`);
});
```

### Status reporting (`reportStatus`, `.on('status')`)

Tasks may also emit `'status'` events, reporting an arbitrary user-readable
string (or `null`) to be reflected in the UI. Task step implementations can
report status as follows:

```ts
const task1 = taskBuilder.step({/*...*/}, async (context, {reportStatus}) => {
  reportStatus('Reticulating splines...'); // <-- emits a 'status' event from task1
  //...
  reportStatus('Searching far and wide...');
  //...
  reportStatus('Done!');
});

task1.on('status', (status: string | null) => {
  if (status != null) {
    logInfo(`Task 1 status: ${status}`);
  }
});
```

A task graph will always report the last status reported by any of its sub-tasks.

### Time-span between two task (`.taskSpan`)

If you want to do something during the time-span between two tasks,
there's a specific method for that. One obvious use for this is
VS Code notifications.

```ts
graph1.taskSpan('step2a', 'step3', async (endPromise, context) => {
  // This runs when step2a starts.
  // `endPromise` resolves when step3 ends.
  vscode.window.withProgress({
    title: 'This notification should show up between step2a and step3!',
    location: vscode.ProgressLocation.Notification,
  }, () => endPromise);
});
```

Although you could write a manual solution based on events, `.taskSpan`
does a lot of error-checking for you, and it will not misbehave if
some task inbetween causes the whole run to crash.

### Getting reference to a specific sub-task (`.getTask`)

You can request a specific subtask (to any depth) by name.
This might be used to listen to an event on that subtask:

```ts
graph1.getTask('step1')?.once('end', () => {
  // <-- do something when step1 ends
});
```

If no subtask by the given name exists, `.getTask` returns `null`.

### Iterating over all task (`.allTasks`)

You can iterate over all (possibly nested) tasks in a task structure like so:

```ts
for (const task of graph1.allTasks()) {
  // <-- do something with the task
}
```

### Streaming terminal logs (`logStream`, `logStreamMode`)

Step functions receive a writable stream they can pipe logs into.
Where these logs go is decided when `.run` is invoked:

```ts
const task1 = taskBuilder.step({/*...*/}, async (context, {logStream}) => {
  //...
  const ls = child_process.spawn('ls');
  ls.stdout.pipe(logStream);
  ls.stderr.pipe(logStream);
  //...
});

await task1.run(context, {logStream: process.stderr});
```

For subtasks in a graph, streaming behaviour is decided by options
passed in the graph construction. Output from certain subtasks can
be piped to the main stream *live*, it can be *discarded*, or it can
be *buffered* until the task is finished and then drained at a moment
when no other task is streaming logs. This can ensure that log output
from multiple parallel tasks is not interleaved in the final output.

```ts
const graph1 = taskBuilder.graph({name: 'graph', chronicleEvent: 'Test'}, [
  step1.options({logStreamMode: 'live'}),
  step2a.options({logStreamMode: 'live', dependencies: [step1]}),
  step2b.options({logStreamMode: 'buffer', dependencies: [step1]}),
  step3.options({logStreamMode: 'live', dependencies: [step2a, step2b]}),
]);

await graph1.run(context, {logStream: process.stderr});
```

In the example above, `step2a` and `step2b` run in parallel, but logs from
`step2b` will only be output once `step2a` has finished running.

### Logging to [Chronicle](https://www.internalfb.com/intern/wiki/Vscode-internals/Chronicle_-_Rich_VS_Code_@_FB_Telemetry/)

When running, tasks will log directly to Chronicle as long as
the argument `logToChronicle: true` is passed when creating a task or
graph. Chronicle events and error codes can also be specified at this time.

Success and error events are written with the same information as is
emitted in the `end` and `error` events, respectively. In addition,
task context is included as well.

### Cancelling tasks (`cancellationToken`)

A `vscode.CancellationTokenSource` can be optionally provided
to Graphs when they are run.  This allows you to externally
cancel the executation of a task.

Step functions receive this cancellation token,
and can use it to poll for previous cancellation
or listen for cancellation being triggered.

```ts
const task1 = taskBuilder.step({/*...*/}, async (context, {cancellationToken}) => {
  //...
  if (cancellationToken?.token.isCancellationRequested) {
    return; // early exit to avoid unnecessary work
  }
  //...
  const buck = child_process.spawn('buck');
  const listener = cancellationToken?.token.onCancellationRequested(() => {
    // cancel long-lived subprocesses via SIGINT
    buck.kill();
  });
  //...
  listener?.dispose(); // don't forget to clean up listeners
});

await task1.run(context, {cancellationToken});

// same applies for graphs:
await graph1.run(context, {cancellationToken});

// when the user clicks a UI cancel button:
cancellationToken.cancel();
```

Graphs will automatically check the cancellation token
before starting new subtasks, and throw an error to prevent
the rest of the graph from executing. This gives basic
support for cancellation even if none of your tasks make use
of the `cancellationToken`.

You can check if a task was cancelled by looking at the token in
the summary.

```ts
task1.once('error', ({cancellationToken}) => {
  const wasCancelled = cancellationToken?.token.isCancellationRequested;
  // do something with `wasCancelled`, e.g. logging or telemetry
})
```

### Logging extra data (`extras`)

If you want the logged event for your task step to contain any extra
data, you can return that data from the step function:

```ts
const task1 = taskBuilder.step({/*...*/}, async (context) => {
  //...
  return {
    extras: {'foo': 'bar'}
  };
});
```

This data will be passed to the `'end'` event, so you can pass it to
Chronicle or the like:

```ts
task1.once('end', ({extras}) => {
  doSomethingWith(extras); // <-- extras.foo === 'bar'
})
```
