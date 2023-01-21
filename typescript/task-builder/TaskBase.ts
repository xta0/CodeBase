import {EventEmitter} from 'events';
import { ChronicleEventName,  ChronicleErrorCode, ChronicleExtras} from "./chronicle";
import {EventsNotSequencedError} from "./errors"

export type TaskBaseParameters =
  | {
      name: ChronicleEventName;
      chronicleErrorCode?: ChronicleErrorCode;
      logToChronicle?: boolean;
    }
  | {
      name: string;
      chronicleEvent: ChronicleEventName;
      chronicleErrorCode?: ChronicleErrorCode;
      logToChronicle?: boolean;
    };

export const defaultChronicleError: ChronicleErrorCode = 'FBTaskRunnerError';

/**
 * Possible return values for task step functions.
 */
export type TaskReturnValue = {
    /** Extra data to be attached to a logged event */
    extras?: ChronicleExtras;
};

export type TaskExecuteOptions = TaskRunOptions & {
    runId: string;
    logStream: NodeJS.WritableStream;
};
  
export const parentRunId = Symbol('parentRunId');

export type TaskRunOptions = {
    /** The stream to which you want to pipe logs produced by the task */
    logStream?: NodeJS.WritableStream;
    /** A token used to externally trigger cancellations and watch when they are requested */
    // cancellationToken?: vscode.CancellationTokenSource;
    cancellationToken?: string;
    /** The run id of the parent of this task, if any (passed by the parent task) */
    [parentRunId]?: string;
};

export type TaskRunStartSummary<Context> = TaskRunOptions & {
    /** The run id of this task (generated using uuid) */
    runId: string;
    /** The log output stream of this task, which can be written to */
    logStream: NodeJS.WritableStream;
    /** The run id of the parent of this task, if any */
    parentRunId?: string;
    /** The run context */
    context: Context;
    /** The time (based on performanceNow) that this task started */
    startTime: number;
  };

/**
 * Values common to a task's 'end' event and 'error' event
 */
export type TaskEndSummaryCommon<Context> = TaskRunStartSummary<Context> & {
    /** The time (based on performanceNow) that this task ended */
    endTime: number;
    /** The duration in ms */
    duration: number;
};

export type TaskRunErrorSummary<Context> = TaskEndSummaryCommon<Context> & {
    /** The thrown error */
    error: Error;
};
  
/**
 * Values passed to a task's 'end' event.
 */
export type TaskRunEndSummary<Context> = TaskReturnValue & TaskEndSummaryCommon<Context>;

export abstract class TaskBase<Context> extends EventEmitter {
    ///// Task Setup /////
    public readonly name: string;
    public readonly logToChronicle: boolean;
    public readonly chronicleEvent: ChronicleEventName;
    public readonly chronicleErrorCode: ChronicleErrorCode;
    constructor(parameters: TaskBaseParameters) {
        super();
        this.name = parameters.name;
    
        this.chronicleEvent =
          'chronicleEvent' in parameters ? parameters.chronicleEvent : parameters.name;
    
        this.chronicleErrorCode = parameters.chronicleErrorCode
          ? parameters.chronicleErrorCode
          : defaultChronicleError;
    
        this.logToChronicle = parameters.logToChronicle === true;
      }
      /**
   * Get a task by name, however deeply nested under this task.
   * @param task the name of the task you're requesting (or the task itself)
   * @returns the task with the given name, or `null` if no such task exists
   */
  public getTask(task: string | TaskBase<Context>): TaskBase<Context> | null {
    if (task instanceof TaskBase) {
      return task;
    } else {
      return this.getNestedTasksDownTo(task)?.pop() ?? null;
    }
  }

  public taskSpan(
    from: string | TaskBase<Context>,
    fromEvent: 'start',
    to: string | TaskBase<Context>,
    toEvent: 'start',
    callback: (
      fromSummary: TaskRunStartSummary<Context>,
      toSummaryPromise: Promise<TaskRunStartSummary<Context>>,
    ) => unknown,
  ): void;
  public taskSpan(
    from: string | TaskBase<Context>,
    fromEvent: 'start',
    to: string | TaskBase<Context>,
    toEvent: 'end',
    callback: (
      fromSummary: TaskRunStartSummary<Context>,
      toSummaryPromise: Promise<TaskRunEndSummary<Context>>,
    ) => unknown,
  ): void;
  public taskSpan(
    from: string | TaskBase<Context>,
    fromEvent: 'end',
    to: string | TaskBase<Context>,
    toEvent: 'start',
    callback: (
      fromSummary: TaskRunEndSummary<Context>,
      toSummaryPromise: Promise<TaskRunStartSummary<Context>>,
    ) => unknown,
  ): void;
  public taskSpan(
    from: string | TaskBase<Context>,
    fromEvent: 'end',
    to: string | TaskBase<Context>,
    toEvent: 'end',
    callback: (
      fromSummary: TaskRunEndSummary<Context>,
      toSummaryPromise: Promise<TaskRunEndSummary<Context>>,
    ) => unknown,
  ): void;

  public taskSpan(
    from: string | TaskBase<Context>,
    fromEvent: 'start' | 'end',
    to: string | TaskBase<Context>,
    toEvent: 'start' | 'end',
    callback: (
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      fromSummary: any,
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      toSummaryPromise: Promise<any>,
    ) => unknown,
  ): void {
    const fromTask = this.getTask(from);
    const toTask = this.getTask(to);

    if (!fromTask || !toTask) {
      return;
    }

    let toEventFired = false;
    toTask.once(toEvent, () => {
      toEventFired = true;
    });

    fromTask.once(fromEvent, fromSummary => {
      // don't invoke callback if the `to` event already fired
      if (toEventFired) {
        return;
      }
      const toSummaryPromise = new Promise<TaskRunEndSummary<Context>>((resolve, reject) => {
        // resolve when the 'to' event fires
        toTask.once(toEvent, resolve);
        // reject if any task inbetween fails (which should propagate to this task)
        this.once('error', (errorSummary: TaskRunErrorSummary<Context>) => {
          reject(errorSummary.error);
        });
        // reject if this task ends without the `to` event ever firing
        this.once('end', () => {
          reject(new EventsNotSequencedError(fromTask.name, fromEvent, toTask.name, toEvent));
        });
      });
      callback(fromSummary, toSummaryPromise);
    });
  }


  ///// Getters /////

  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  public progress() {
    return this._progress ?? 0.0;
  }


  ///// Abstract Methods /////

  /**
   * Iterate over all tasks in the structure rooted at this task
   * in arbitrary order.
   */
  public abstract allTasks(): Iterable<TaskBase<Context>>;
    /**
   * Find a task by name inside the entire composition and return
   * the nesting path from here to there. This is a public method
   * for technical reasons, but only needs to be used internally.
   *
   * @protected
   * @return the list of tasks between this one down to the requested task
   *         if it exists, and null otherwise
   */
  public abstract getNestedTasksDownTo(name: string): TaskBase<Context>[] | null;
   /**
   * Verify that there are no duplicate task names inside this task,
   * and return a set of all task names. This is a public method
   * for technical reasons, but only needs to be used internally.
   * @protected
   */
   public abstract verifyTaskNames(): Set<string>;

   ///// Protected Methods /////
 
   // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
   protected setProgress(newProgress: number) {
     if (this._progress !== newProgress) {
       this._progress = newProgress;
       this.emit('progress', this._progress);
     }
   }
 
   // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
   protected setStatus(newStatus: string | null) {
     if (this._status !== newStatus) {
       this._status = newStatus;
       this.emit('status', this._status);
     }
   }

   ///// Private Fields /////

   private _progress?: number;
   private _status?: string | null;


}
