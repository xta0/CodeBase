export class EventsNotSequencedError extends Error {
    constructor(
      public fromTask: string,
      public fromEvent: string,
      public toTask: string,
      public toEvent: string,
    ) {
      super(`Event '${toTask}:${toEvent}' did not fire after '${fromTask}:${fromEvent}'`);
    }
  }

  /**
 * This error type indicates an error was thrown by the p-graph
 * library, indicating some problem with the graph definition.
 * That library doesn't provide a programmatic way to identify
 * its errors, so we just pass the message along.
 */
export class TaskPGraphBuildtimeError extends Error {
  constructor(public error: Error) {
    super(error.message);
  }
}

  export class TaskPostconditionFailure extends Error {
    constructor(public taskName: string, public missingFields: string[]) {
      super(
        // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
        `The task '${taskName}' failed to assign context values for promised fields: ${missingFields}`,
      );
    }
  }

  /**
 * This error type indicates that static analysis of a TaskGraph
 * indicates one of its inner tasks' precondition will fail, i.e.,
 * that some task would not be getting the context fields that it expects.
 */
export class TaskBuildtimePreconditionFailure extends Error {
  constructor(public taskName: string, public missingFields: string[]) {
    super(
      // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
      `It looks like the task '${taskName}' expects the following context fields which are not guaranteed by the graph: ${missingFields}`,
    );
  }
}

/**
 * This error type indicates that static analysis of a TaskGraph or TaskDecider
 * indicates its postcondition may fail in a predictable way, i.e.,
 * that it may not assign the context fields it promises.
 */
export class TaskBuildtimePostconditionFailure extends Error {
  constructor(public taskName: string, public missingFields: string[]) {
    super(
      // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
      `It looks like the task '${taskName}' promises to assign the following context fields, but may not do so: ${missingFields}`,
    );
  }
}

/**
 * This error type indicates that a task decider function attempted
 * to run more than one subtask.
 */
export class MultipleDeciderTasksInvokedError extends Error {
  constructor(public taskName: string, public subtaskNames: string[]) {
    // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
    super(`The task decider '${taskName}' attempted to run more than one subtask: ${subtaskNames}`);
  }
}

/**
 * This error type indicates that a task decider function called
 * a subtask runner, but did not await it.
 */
export class SubtaskNotAwaitedError extends Error {
  constructor(public taskName: string, public subtaskName: string) {
    super(
      `The task decider '${taskName}' invoked subtask '${subtaskName}' without awaiting its promise`,
    );
  }
}

/**
 * This error type indicates that a task graph/decider contains multiple
 * (possibly nested) tasks with the same name.
 */
export class TaskDuplicateNameError extends Error {
  constructor(public taskName: string, public duplicateName: string) {
    super(
      `The task '${taskName}' contains multiple (possibly nested) tasks with the name '${duplicateName}'`,
    );
  }
}
