/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */

import {
    MultipleDeciderTasksInvokedError,
    SubtaskNotAwaitedError,
    TaskBuildtimePostconditionFailure,
    TaskDuplicateNameError,
  } from './errors';
  import { TaskExecuteOptions } from './TaskBase';
  import { parentRunId } from './TaskBase';
  import {ControlledContext, Task, TaskParameters} from './Task';
  import {TaskBase} from './TaskBase';
  
  ////////////////////////////////////////////////////////////////////////////////
  
  /**
   * The function provided when constructing a task decider,
   * responsible for running the logic that decides which task to run.
   */
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  export type DeciderFunction<Context extends object, ExpectedFields extends keyof Context> = (
    context: ControlledContext<Context, ExpectedFields, never>,
    taskRunners: {[name: string]: () => Promise<void>},
  ) => Promise<void>;
  
  ////////////////////////////////////////////////////////////////////////////////
  
  /**
   * A TaskDecider allows writing custom logic to decide which of a set of
   * predeclared subtasks is run, and possibly to catch and handle exceptions
   * thrown from tasks.
   *
   * Note: Only use this if necessary. Typescript cannot always guarantee
   * type safety w.r.t. assignedFields.
   */
  export class TaskDecider<
    // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
    Context extends object,
    ExpectedFields extends keyof Context,
    AssignedFields extends keyof Context,
  > extends Task<Context, ExpectedFields, AssignedFields> {
    ///// Public /////
  
    constructor(
      parameters: TaskParameters<Context, ExpectedFields, AssignedFields>,
      candidateTasks: Array<Task<Context, ExpectedFields, keyof Context>>,
      deciderFunction: DeciderFunction<Context, ExpectedFields>,
    ) {
      super(parameters);
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment -- Please fix as you edit this code
      this._candidates = new Map();
      for (const task of candidateTasks) {
        if (this._candidates.has(task.name)) {
          throw new TaskDuplicateNameError(this.name, task.name);
        }
        this._candidates.set(task.name, task);
      }
  
      this._deciderFunction = deciderFunction;
  
      this.verifyTaskNames();
      this.performContractChecks();
    }
  
    override *allTasks(): Iterable<TaskBase<Context>> {
      yield this;
      for (const task of this._candidates.values()) {
        yield* task.allTasks();
      }
    }
  
    ///// Protected /////
  
    override getNestedTasksDownTo(name: string): TaskBase<Context>[] | null {
      if (this.name === name) {
        return [this];
      }
      for (const task of this._candidates.values()) {
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
      for (const task of this._candidates.values()) {
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
      // Set up taskrunner functions
      const subtasksInvoked: string[] = [];
      let subtaskIsSettled = false;
      const taskRunners: {[name: string]: () => Promise<void>} = {};
      for (const task of this._candidates.values()) {
        taskRunners[task.name] = async () => {
          subtasksInvoked.push(task.name);
          if (subtasksInvoked.length === 1) {
            try {
              await task.run(context, {
                [parentRunId]: options.runId,
                logStream: options.logStream,
              });
            } finally {
              subtaskIsSettled = true;
            }
          }
        };
      }
  
      // Run decider function
      await this._deciderFunction(context, taskRunners);
  
      // Throw if more than one subtask was invoked
      if (subtasksInvoked.length > 1) {
        throw new MultipleDeciderTasksInvokedError(this.name, subtasksInvoked);
      }
  
      // Throw if the decider function settles before the subtask runner does.
      // (i.e., if the subtask promise was not awaited inside the decider function)
      if (subtasksInvoked.length > 0 && !subtaskIsSettled) {
        throw new SubtaskNotAwaitedError(this.name, subtasksInvoked[0]);
      }
    }
  
    ///// Private /////
  
    private _candidates: Map<string, Task<Context, ExpectedFields, keyof Context>>;
    private _deciderFunction: DeciderFunction<Context, ExpectedFields>;
  
    /**
     * Detect subtasks that cannot satisfy the `assignsFields` guarantees of this task.
     */
    private performContractChecks() {
      const fieldsNotAssigned = new Set<string>();
      for (const aName of this.assignedFields as string[]) {
        if (
          ![...this._candidates.values()].every(task =>
            task.assignedFields.some(subAName => subAName === aName),
          )
        ) {
          fieldsNotAssigned.add(aName);
        }
      }
  
      if (fieldsNotAssigned.size > 0) {
        throw new TaskBuildtimePostconditionFailure(this.name, [...fieldsNotAssigned]);
      }
    }
  }
  