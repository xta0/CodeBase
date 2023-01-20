"use strict";
/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.TaskBuilder = void 0;
var Task_1 = require("./Task");
var TaskStep_1 = require("./TaskStep");
var TaskGraph_1 = require("./TaskGraph");
var TaskGraphNode_1 = require("./TaskGraphNode");
var TaskDecider_1 = require("./TaskDecider");
////////////////////////////////////////////////////////////////////////////////
/**
 * Instantiate this class once per 'project', and then use it
 * to define task steps and task graphs.
 */
// eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
var TaskBuilder = /** @class */ (function () {
    function TaskBuilder() {
    }
    /**
     * Build a task able to run an asynchronous function.
     * @param parameters the metadata for this task step
     * @param stepFunction the function executing this task step
     * @returns a task object with an async `run` method
     */
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskBuilder.prototype.step = function (parameters, stepFunction) {
        return new TaskStep_1.TaskStep(parameters, stepFunction);
    };
    /**
     * Build a task able to run multiple sub-tasks in the specified partial order.
     * @param parameters the metadata for this task graph
     * @param tasks the sub-tasks of the graph with possible `.runAfter` suffixes to specify ordering
     * @returns a task object with an async `run` method
     */
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskBuilder.prototype.graph = function (parameters, tasks) {
        var taskNodes = tasks.map(function (t) { return (t instanceof Task_1.Task ? new TaskGraphNode_1.TaskGraphNode(t) : t); });
        return new TaskGraph_1.TaskGraph(parameters, taskNodes);
    };
    /**
     * Build a task which can invoke any (or none) of a pre-declared set of subtasks,
     * and/or handle exceptions thrown by such subtasks, by writing custom async logic.
     * @param parameters the metadata for this task decider
     * @param candidateTasks possible subtasks to invoke from the decider function
     * @param deciderFunction custom logic used to possibly run a subtask
     * @returns a task object with an async `run` method
     */
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskBuilder.prototype.decider = function (parameters, candidateTasks, deciderFunction) {
        return new TaskDecider_1.TaskDecider(parameters, candidateTasks, deciderFunction);
    };
    return TaskBuilder;
}());
exports.TaskBuilder = TaskBuilder;
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
