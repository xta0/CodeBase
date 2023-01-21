import { TaskBaseParameters } from "./TaskBase";
import { TaskBase } from "./TaskBase";
import { TaskGraphNodeOptions, TaskGraphNode } from "./TaskGraphNode";
import { TaskRunOptions } from "./TaskBase";
import {writableNoopStream} from 'noop-stream';
import { parentRunId } from "./TaskBase";
import { TaskRunStartSummary, TaskRunEndSummary } from "./TaskBase";
import { TaskReturnValue } from "./TaskBase";
import { TaskExecuteOptions } from "./TaskBase";
// import { TaskPostconditionFailure } from "./errors";

/**
 * The parameters to pass to the Task constructor.
 */
export type TaskParameters<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> = TaskBaseParameters & {
  expectsFields?: ExpectedFields[];
  assignsFields?: AssignedFields[];
};

/**
 * The Context type with constraints imposed on it by
 * `expectsFields` and `assignsFields` specs.
 */
export type ControlledContext<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> = Context & Required<Pick<Context, ExpectedFields>> & Readonly<Omit<Context, AssignedFields>>;


////////////////////////////////////////////////////////////////////////////////

/**
 * A Task represents an asynchronous operation performed by this module.
 * It can be either a simple step or a dependency graph of sub-tasks,
 * depending on the instantiated subclass (the 'Composite' design pattern).
 */
export abstract class Task<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> extends TaskBase<Context> {
  ///// Task Setup /////

  constructor(parameters: TaskParameters<Context, ExpectedFields, AssignedFields>) {
    super(parameters);
    this._expectedFields = parameters.expectsFields ?? [];
    this._assignedFields = parameters.assignsFields ?? [];
  }

  /**
   * If this task is to be used as part of a task graph, a call to this function can be used
   * to represent both this task and some options relevant in the context of that graph.
   * @param options.dependencies the other tasks in the graph that need to be run before this one
   * @param options.progressWeight the weight this task's progress should have in the overall
   *                               progress of the graph
   * @returns an object to be used as part of a task-graph specification
   */
  options(
    options: Partial<TaskGraphNodeOptions<Context>>,
  ): TaskGraphNode<Context, ExpectedFields, AssignedFields> {
    return new TaskGraphNode(this, options);
  }

  /**
   * If this task is to be used as part of a task graph, a call to this function can be used
   * to represent both this task and its dependencies in that graph.
   * You can use this instead of the `options` method in case there are no other options.
   * @param dependencies the other tasks in the graph that need to be run before this one
   * @returns an object to be used as part of a task-graph specification
   */
  runAfter(
    ...dependencies: TaskBase<Context>[]
  ): TaskGraphNode<Context, ExpectedFields, AssignedFields> {
    return this.options({dependencies});
  }

  ///// Task Running /////

  /**
   * Run this task in the given context with the given options.
   * @sealed
   */
  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  public async run(
    context: ControlledContext<Context, ExpectedFields, AssignedFields>,
    options: TaskRunOptions = {},
  ) {
    const runId = ""
    const logStream = options.logStream ?? writableNoopStream();
    const startTime = performance.now();
    const startRunSummary: TaskRunStartSummary<Context> = {
      ...options,
      runId,
      logStream,
      parentRunId: options[parentRunId],
      context,
      startTime,
    };
    this.emit('start', startRunSummary);
    this.setProgress(0.0);
    let returnValue: TaskReturnValue | void;
    try {
      const executeOptions = {runId, logStream, ...options};
      // eslint-disable-next-line prefer-const -- Please fix as you edit this code
      returnValue = await this.execute(context, executeOptions);
      this.postcondition(context);
      this.setProgress(1.0);

      const endTime = performance.now();
      const duration = Math.round(endTime - startTime);
      const summary: TaskRunEndSummary<Context> = {
        ...startRunSummary,
        endTime,
        duration,
        ...returnValue,
      };

      this.emit('end', summary);
      if (this.logToChronicle) {
        // const params = this.chronicleParams(summary, context);
        // globalChronicle.logEvent(this.chronicleEvent, {isHumanTriggered: true, ...params});
      }
    } catch (error) {
      const err = error as Error
      const endTime = performance.now();
      const duration = Math.round(endTime - startTime);
      const errorSummary = {
        ...startRunSummary,
        endTime,
        duration,
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment -- Please fix as you edit this code
        err,
      };
      // Emit error signal, but prevent it from crashing process by adding empty listener.
      // We only want it for cross-cutting concerns like logging, and the error still
      // needs to be dealt with anyway because we're rethrowing it.
      // eslint-disable-next-line @typescript-eslint/no-empty-function -- Please fix as you edit this code
      this.once('error', () => {});
      this.emit('error', errorSummary);
      if (this.logToChronicle) {
        // const params = this.chronicleErrorParams(errorSummary, context);
        // globalChronicle.logError(this.chronicleEvent, {isHumanTriggered: true, ...params});
      }
      throw error;
    }
  }

  // private chronicleParams(
  //   summary: TaskRunEndSummary<Context>,
  //   context: ControlledContext<Context, ExpectedFields, AssignedFields>,
  // ): ChroniclePartialCommonParams<ChronicleBaseParams> {
  //   return {
  //     id: summary.runId,
  //     parentId: summary.parentRunId,
  //     duration: summary.duration,
  //     timestamp: summary.endTime,
  //     extras: {
  //       name: this.name,
  //       context: {...context},
  //     },
  //   };
  // }

  // private chronicleErrorParams(
  //   errorSummary: TaskRunErrorSummary<Context>,
  //   context: ControlledContext<Context, ExpectedFields, AssignedFields>,
  // ): ChroniclePartialCommonErrorParams<ChronicleBaseParams> {
  //   return {
  //     ...this.chronicleParams(errorSummary, context),
  //     error: {
  //       errorCode: this.chronicleErrorCode,
  //       errorMessage: errorSummary.error?.message ?? String(errorSummary.error),
  //     },
  //   };
  // }

  private postcondition(context: Context) {
    const missingFields = this.assignedFields.filter(
      key => !(key in context && context[key] !== undefined),
    );
    if (missingFields.length > 0) {
      // throw new TaskPostconditionFailure(this.name, missingFields);
    }
  }

  ///// Getters /////

  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  get expectedFields() {
    return this._expectedFields;
  }

  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  get assignedFields() {
    return this._assignedFields;
  }

  ///// Abstract Methods /////

  /**
   * The subclass-specific logic for executing a task.
   * @protected
   * @param context the context under which to execute this task
   * @param options runtime options
   */
  protected abstract execute(
    context: ControlledContext<Context, ExpectedFields, AssignedFields>,
    options: TaskExecuteOptions,
  ): Promise<TaskReturnValue | void>;

  ///// Private Fields /////

  private _expectedFields: ExpectedFields[];
  private _assignedFields: AssignedFields[];
}
