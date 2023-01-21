/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */

import { TaskExecuteOptions, TaskReturnValue } from './TaskBase';
import {ControlledContext, Task, TaskParameters } from './Task';
import {TaskBase} from './TaskBase';
// import * as vscode from 'vscode';

////////////////////////////////////////////////////////////////////////////////

/**
 * Values and functions passed into task step functions by
 * the this module to support certain cross-cutting concerns.
 */
export type TaskMetaContext = {
  /** Report progress of this task as a number between 0.0 and 1.0 */
  readonly reportProgress: (progress: number) => unknown;
  /** Report a status string from this task */
  readonly reportStatus: (status: string | null) => unknown;
  /** The stream into which to write logs / terminal output */
  readonly logStream: NodeJS.WritableStream;
  /** A token used to externally trigger cancellations and watch when they are requested */
//   readonly cancellationToken?: vscode.CancellationTokenSource;
  readonly cancellationToken?: string;
};

/**
 * The function provided when constructing a task step,
 * responsible for performing the task.
 */
export type StepFunction<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> = (
  context: ControlledContext<Context, ExpectedFields, AssignedFields>,
  metaContext: TaskMetaContext,
) => Promise<TaskReturnValue | void>;

////////////////////////////////////////////////////////////////////////////////

/**
 * A TaskStep represents a single asynchronous step defined by an asynchronous function.
 * More complex tasks can be defined by putting these inside a TaskGraph.
 *
 * @deprecated Use PtyWithInterruptibleChildren or runMultiChildTask instead.
 * They have similar sequencing capabilities, with a simpler API and ability to run
 * in an interactive terminal.
 */
export class TaskStep<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> extends Task<Context, ExpectedFields, AssignedFields> {
  ///// Public /////

  constructor(
    parameters: TaskParameters<Context, ExpectedFields, AssignedFields>,
    stepFunction: StepFunction<Context, ExpectedFields, AssignedFields>,
  ) {
    super(parameters);
    this._stepFunction = stepFunction;
  }

  override *allTasks(): Iterable<TaskBase<Context>> {
    yield this;
  }

  ///// Protected /////

  override getNestedTasksDownTo(name: string): TaskBase<Context>[] | null {
    return this.name === name ? [this] : null;
  }

  override verifyTaskNames(): Set<string> {
    return new Set([this.name]);
  }

  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  override execute(
    context: ControlledContext<Context, ExpectedFields, AssignedFields>,
    options: TaskExecuteOptions,
  ) {
    return this._stepFunction(context, {
      reportProgress: (progress: number) => {
        // clamping between 0.0 and 1.0
        this.setProgress(Math.max(0.0, Math.min(1.0, progress)));
      },
      reportStatus: (status: string | null) => {
        this.setStatus(status);
      },
      logStream: options.logStream,
      cancellationToken: options.cancellationToken,
    });
  }

  ///// Private /////

  private _stepFunction: StepFunction<Context, ExpectedFields, AssignedFields>;
}
