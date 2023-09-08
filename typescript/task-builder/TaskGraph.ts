/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */

import pGraph, {DependencyList, PGraphNodeMap} from 'p-graph';
import {
  TaskBuildtimePostconditionFailure,
  TaskBuildtimePreconditionFailure,
  TaskDuplicateNameError,
} from './errors';
import { TaskExecuteOptions } from './TaskBase';
import { parentRunId } from './TaskBase';
import {Task, TaskParameters, ControlledContext} from './Task';
import {TaskBase} from './TaskBase';
import {writableNoopStream} from 'noop-stream';
import {PassThrough, pipeline} from 'stream';
import {promisify} from 'util';
import {TaskGraphNode} from './TaskGraphNode';

const pPipeline = promisify(pipeline);

////////////////////////////////////////////////////////////////////////////////

/**
 * A TaskGraph is an asynchronous task composed of smaller tasks. These sub-tasks
 * are related through a dependency graph, allowing some to run in parallel while
 * requiring strict sequencing between others.
 *
 * They have similar sequencing capabilities, with a simpler API and ability to run
 * in an interactive terminal.
 */
export class TaskGraph<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> extends Task<Context, ExpectedFields, AssignedFields> {
  ///// Public /////

  constructor(
    parameters: TaskParameters<Context, ExpectedFields, AssignedFields>,
    nodes: TaskGraphNode<Context, ExpectedFields | AssignedFields, AssignedFields>[],
  ) {
    super(parameters);
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment -- Please fix as you edit this code
    this._nodes = new Map();
    for (const node of nodes) {
      if (this._nodes.has(node.task.name)) {
        throw new TaskDuplicateNameError(this.name, node.task.name);
      }
      this._nodes.set(node.task.name, node);
    }

    this._dependencyList = [];
    for (const [name, node] of this._nodes.entries()) {
      for (const dependency of node.options.dependencies) {
        this._dependencyList.push([dependency.name, name]);
      }
    }

    this.verifyTaskNames();
    this.performPGraphChecks();
    this.performContractChecks();
    this.setupProgressHandlers();
    this.setupStatusHandlers();
  }

  override *allTasks(): Iterable<TaskBase<Context>> {
    yield this;
    for (const {task} of this._nodes.values()) {
      yield* task.allTasks();
    }
  }

  ///// Protected /////

  override getNestedTasksDownTo(name: string): TaskBase<Context>[] | null {
    if (this.name === name) {
      return [this];
    }
    for (const {task} of this._nodes.values()) {
      const trace = task.getNestedTasksDownTo(name);
      if (trace) {
        trace.unshift(this);
        return trace;
      }
    }
    return null;
  }

  override verifyTaskNames(): Set<string> {
    const names = new Set([this.name]);
    for (const {task} of this._nodes.values()) {
      for (const name of task.verifyTaskNames()) {
        if (names.has(name)) {
          throw new TaskDuplicateNameError(this.name, name);
        }
        names.add(name);
      }
    }
    return names;
  }

  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  override async execute(
    context: ControlledContext<Context, ExpectedFields, AssignedFields>,
    options: TaskExecuteOptions,
  ) {
    const nodeMap: PGraphNodeMap = new Map(
      [...this._nodes.entries()].map(([name, node]) => [
        name,
        {
          run: async () => {
            // When cancelled, prevent running any further tasks in the graph
            // if (options.cancellationToken?.token.isCancellationRequested) {
            //   throw new Error('Cancelled');
            // }

            // Note: The `node.task.run` function will ensure that the
            // required keys are actually defined. This is not something
            // TypeScript can guarantee for a node in a complex dependency
            // graph, so we use 'as' here to assume the more specific type.
            await node.task.run(
              context as ControlledContext<
                Context,
                ExpectedFields | AssignedFields,
                AssignedFields
              >,
              {
                [parentRunId]: options.runId,
                logStream: this.setupLogStreamForNode(node, options.logStream),
                cancellationToken: options.cancellationToken,
              },
            );
            await this.flushBufferedStreams(options.logStream);
          },
        },
      ]),
    );

    await pGraph(nodeMap, this._dependencyList).run();

    await this.flushBufferedStreams(options.logStream);
  }

  ///// Private /////

  private _nodes: Map<
    string,
    TaskGraphNode<Context, ExpectedFields | AssignedFields, AssignedFields>
  >;
  private _dependencyList: DependencyList;

  /**
   * Detect cycles, unknown dependencies and other bad conditions
   * checked by the pGraph function.
   */
  private performPGraphChecks() {
    try {
      // eslint-disable-next-line @typescript-eslint/no-empty-function -- Please fix as you edit this code
      const dummyNodes = new Map([...this._nodes.keys()].map(name => [name, {async run() {}}]));
      pGraph(dummyNodes, this._dependencyList);
    } catch (error) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-argument -- Please fix as you edit this code
      // throw new TaskPGraphBuildtimeError(error);
    }
  }

  /**
   * Detect inconsistencies between the `expectsFields` and `assignsFields`
   * contracts of this TaskGraph itself and the Tasks inside it using a DFS traversal.
   */
  private performContractChecks() {
    const fieldsAfter: {[name: string]: Set<string>} = {
      _initial_: new Set(this.expectedFields),
    };

    const processFieldsFor = (name: string): void => {
      if (!(name in fieldsAfter)) {
        // eslint-disable-next-line @typescript-eslint/no-non-null-assertion -- Please fix as you edit this code
        const node = this._nodes.get(name)!;

        const fieldsBefore = new Set(fieldsAfter._initial_);
        for (const dependency of node.options.dependencies) {
          processFieldsFor(dependency.name);
          for (const key of fieldsAfter[dependency.name]) {
            fieldsBefore.add(key);
          }
        }

        const fieldsMissingBefore = new Set<string>(node.task.expectedFields);
        for (const field of fieldsBefore) {
          fieldsMissingBefore.delete(field);
        }
        if (fieldsMissingBefore.size > 0) {
          throw new TaskBuildtimePreconditionFailure(node.task.name, [...fieldsMissingBefore]);
        }

        fieldsAfter[name] = fieldsBefore;
        for (const field of node.task.assignedFields) {
          fieldsAfter[name].add(field);
        }
      }
    };

    const fieldsNotAssigned = new Set<string>(this.assignedFields);
    for (const name of this._nodes.keys()) {
      processFieldsFor(name);
      for (const field of fieldsAfter[name]) {
        fieldsNotAssigned.delete(field);
      }
    }

    if (fieldsNotAssigned.size > 0) {
      throw new TaskBuildtimePostconditionFailure(this.name, [...fieldsNotAssigned]);
    }
  }

  private setupProgressHandlers() {
    let totalWeight = 0.0;
    for (const node of this._nodes.values()) {
      totalWeight += node.options.progressWeight;
    }
    for (const node of this._nodes.values()) {
      node.on('progressUpdate', () => {
        let totalWeightedProgress = 0.0;
        for (const {weightedProgress} of this._nodes.values()) {
          totalWeightedProgress += weightedProgress;
        }
        this.setProgress(totalWeightedProgress / totalWeight);
      });
    }
  }

  private setupStatusHandlers() {
    for (const node of this._nodes.values()) {
      node.task.on('status', (status: string | null) => {
        this.setStatus(status);
      });
    }
  }

  private _liveLogStreamCount = 0;
  private _bufferedLogStreams: PassThrough[] = [];

  private setupLogStreamForNode(
    node: TaskGraphNode<Context, ExpectedFields | AssignedFields, AssignedFields>,
    logStream: NodeJS.WritableStream,
  ): NodeJS.WritableStream {
    switch (node.options.logStreamMode) {
      case 'discard':
        return writableNoopStream();
      case 'live': {
        // We pass a PassThrough instead of the logStream itself to prevent
        // an 'end' signal in the subtask from being propagated.
        const logStreamProxy = new PassThrough();
        logStreamProxy.pipe(logStream, {end: false});
        this._liveLogStreamCount++;
        node.task.once('end', () => {
          logStreamProxy.end();
          this._liveLogStreamCount--;
        });

        // Add event listeners to original (non-proxy) logStream.
        // This allows us to listen with `logStreamProxy.on('event', ...)` and
        // still run `logStream.emit('event', ...)` to trigger it.
        logStreamProxy.on = (...args) => {
          logStream.on(...args);
          return logStreamProxy;
        };

        return logStreamProxy;
      }
      case 'buffer': {
        //
        const bufferedLogStream = new PassThrough();
        node.task.once('end', () => {
          this._bufferedLogStreams.push(bufferedLogStream);
        });
        return bufferedLogStream;
      }
    }
  }

  private async flushBufferedStreams(logStream: NodeJS.WritableStream) {
    if (this._liveLogStreamCount === 0) {
      for (const bufferedLogStream of this._bufferedLogStreams) {
        const receiver = new PassThrough();
        receiver.pipe(logStream, {end: false});
        const promise = pPipeline(bufferedLogStream, receiver);
        bufferedLogStream.end();
        // eslint-disable-next-line no-await-in-loop
        await promise;
      }
    }
  }
}
