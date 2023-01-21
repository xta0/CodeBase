/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */

import {Task, TaskParameters} from './Task';
import {StepFunction, TaskStep} from './TaskStep';
import {TaskGraph} from './TaskGraph';
import {TaskGraphNode} from './TaskGraphNode';
import {DeciderFunction, TaskDecider} from './TaskDecider';

////////////////////////////////////////////////////////////////////////////////

/**
 * Instantiate this class once per 'project', and then use it
 * to define task steps and task graphs.
 */
// eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
export class TaskBuilder<Context extends object> {
  /**
   * Build a task able to run an asynchronous function.
   * @param parameters the metadata for this task step
   * @param stepFunction the function executing this task step
   * @returns a task object with an async `run` method
   */
  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  step<ExpectedFields extends keyof Context = never, AssignedFields extends keyof Context = never>(
    parameters: TaskParameters<Context, ExpectedFields, AssignedFields>,
    stepFunction: StepFunction<Context, ExpectedFields, AssignedFields>,
  ) {
    return new TaskStep(parameters, stepFunction);
  }

  /**
   * Build a task able to run multiple sub-tasks in the specified partial order.
   * @param parameters the metadata for this task graph
   * @param tasks the sub-tasks of the graph with possible `.runAfter` suffixes to specify ordering
   * @returns a task object with an async `run` method
   */
  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  graph<ExpectedFields extends keyof Context = never, AssignedFields extends keyof Context = never>(
    parameters: TaskParameters<Context, ExpectedFields, AssignedFields>,
    tasks: (
      | TaskGraphNode<Context, ExpectedFields | AssignedFields, AssignedFields>
      | Task<Context, ExpectedFields | AssignedFields, AssignedFields>
    )[],
  ) {
    const taskNodes = tasks.map(t => (t instanceof Task ? new TaskGraphNode(t) : t));
    return new TaskGraph(parameters, taskNodes);
  }

  /**
   * Build a task which can invoke any (or none) of a pre-declared set of subtasks,
   * and/or handle exceptions thrown by such subtasks, by writing custom async logic.
   * @param parameters the metadata for this task decider
   * @param candidateTasks possible subtasks to invoke from the decider function
   * @param deciderFunction custom logic used to possibly run a subtask
   * @returns a task object with an async `run` method
   */
  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
  decider<
    ExpectedFields extends keyof Context = never,
    AssignedFields extends keyof Context = never,
  >(
    parameters: TaskParameters<Context, ExpectedFields, AssignedFields>,
    candidateTasks: Task<Context, ExpectedFields, keyof Context>[],
    deciderFunction: DeciderFunction<Context, ExpectedFields>,
  ) {
    return new TaskDecider(parameters, candidateTasks, deciderFunction);
  }
}

// The reason we need a class like this is to separate the
// explicitly required `Context` type parameter from the
// automatically inferred `ExpectedFields` and `AssignedFields`.
// If any type parameter is specified explicitly, TypeScript is
// currently unable to infer any others from function arguments.
//
// See: https://github.com/microsoft/TypeScript/issues/16597
//
// The only current solution is currying, which is essentially
// what this class does.
