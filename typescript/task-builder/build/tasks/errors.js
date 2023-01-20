"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.TaskDuplicateNameError = exports.SubtaskNotAwaitedError = exports.MultipleDeciderTasksInvokedError = exports.TaskBuildtimePostconditionFailure = exports.TaskBuildtimePreconditionFailure = exports.TaskPostconditionFailure = exports.TaskPGraphBuildtimeError = exports.EventsNotSequencedError = void 0;
var EventsNotSequencedError = /** @class */ (function (_super) {
    __extends(EventsNotSequencedError, _super);
    function EventsNotSequencedError(fromTask, fromEvent, toTask, toEvent) {
        var _this = _super.call(this, "Event '".concat(toTask, ":").concat(toEvent, "' did not fire after '").concat(fromTask, ":").concat(fromEvent, "'")) || this;
        _this.fromTask = fromTask;
        _this.fromEvent = fromEvent;
        _this.toTask = toTask;
        _this.toEvent = toEvent;
        return _this;
    }
    return EventsNotSequencedError;
}(Error));
exports.EventsNotSequencedError = EventsNotSequencedError;
/**
* This error type indicates an error was thrown by the p-graph
* library, indicating some problem with the graph definition.
* That library doesn't provide a programmatic way to identify
* its errors, so we just pass the message along.
*/
var TaskPGraphBuildtimeError = /** @class */ (function (_super) {
    __extends(TaskPGraphBuildtimeError, _super);
    function TaskPGraphBuildtimeError(error) {
        var _this = _super.call(this, error.message) || this;
        _this.error = error;
        return _this;
    }
    return TaskPGraphBuildtimeError;
}(Error));
exports.TaskPGraphBuildtimeError = TaskPGraphBuildtimeError;
var TaskPostconditionFailure = /** @class */ (function (_super) {
    __extends(TaskPostconditionFailure, _super);
    function TaskPostconditionFailure(taskName, missingFields) {
        var _this = _super.call(this, 
        // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
        "The task '".concat(taskName, "' failed to assign context values for promised fields: ").concat(missingFields)) || this;
        _this.taskName = taskName;
        _this.missingFields = missingFields;
        return _this;
    }
    return TaskPostconditionFailure;
}(Error));
exports.TaskPostconditionFailure = TaskPostconditionFailure;
/**
* This error type indicates that static analysis of a TaskGraph
* indicates one of its inner tasks' precondition will fail, i.e.,
* that some task would not be getting the context fields that it expects.
*/
var TaskBuildtimePreconditionFailure = /** @class */ (function (_super) {
    __extends(TaskBuildtimePreconditionFailure, _super);
    function TaskBuildtimePreconditionFailure(taskName, missingFields) {
        var _this = _super.call(this, 
        // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
        "It looks like the task '".concat(taskName, "' expects the following context fields which are not guaranteed by the graph: ").concat(missingFields)) || this;
        _this.taskName = taskName;
        _this.missingFields = missingFields;
        return _this;
    }
    return TaskBuildtimePreconditionFailure;
}(Error));
exports.TaskBuildtimePreconditionFailure = TaskBuildtimePreconditionFailure;
/**
 * This error type indicates that static analysis of a TaskGraph or TaskDecider
 * indicates its postcondition may fail in a predictable way, i.e.,
 * that it may not assign the context fields it promises.
 */
var TaskBuildtimePostconditionFailure = /** @class */ (function (_super) {
    __extends(TaskBuildtimePostconditionFailure, _super);
    function TaskBuildtimePostconditionFailure(taskName, missingFields) {
        var _this = _super.call(this, 
        // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
        "It looks like the task '".concat(taskName, "' promises to assign the following context fields, but may not do so: ").concat(missingFields)) || this;
        _this.taskName = taskName;
        _this.missingFields = missingFields;
        return _this;
    }
    return TaskBuildtimePostconditionFailure;
}(Error));
exports.TaskBuildtimePostconditionFailure = TaskBuildtimePostconditionFailure;
/**
 * This error type indicates that a task decider function attempted
 * to run more than one subtask.
 */
var MultipleDeciderTasksInvokedError = /** @class */ (function (_super) {
    __extends(MultipleDeciderTasksInvokedError, _super);
    function MultipleDeciderTasksInvokedError(taskName, subtaskNames) {
        var _this = 
        // eslint-disable-next-line @typescript-eslint/restrict-template-expressions -- Please fix as you edit this code
        _super.call(this, "The task decider '".concat(taskName, "' attempted to run more than one subtask: ").concat(subtaskNames)) || this;
        _this.taskName = taskName;
        _this.subtaskNames = subtaskNames;
        return _this;
    }
    return MultipleDeciderTasksInvokedError;
}(Error));
exports.MultipleDeciderTasksInvokedError = MultipleDeciderTasksInvokedError;
/**
 * This error type indicates that a task decider function called
 * a subtask runner, but did not await it.
 */
var SubtaskNotAwaitedError = /** @class */ (function (_super) {
    __extends(SubtaskNotAwaitedError, _super);
    function SubtaskNotAwaitedError(taskName, subtaskName) {
        var _this = _super.call(this, "The task decider '".concat(taskName, "' invoked subtask '").concat(subtaskName, "' without awaiting its promise")) || this;
        _this.taskName = taskName;
        _this.subtaskName = subtaskName;
        return _this;
    }
    return SubtaskNotAwaitedError;
}(Error));
exports.SubtaskNotAwaitedError = SubtaskNotAwaitedError;
/**
 * This error type indicates that a task graph/decider contains multiple
 * (possibly nested) tasks with the same name.
 */
var TaskDuplicateNameError = /** @class */ (function (_super) {
    __extends(TaskDuplicateNameError, _super);
    function TaskDuplicateNameError(taskName, duplicateName) {
        var _this = _super.call(this, "The task '".concat(taskName, "' contains multiple (possibly nested) tasks with the name '").concat(duplicateName, "'")) || this;
        _this.taskName = taskName;
        _this.duplicateName = duplicateName;
        return _this;
    }
    return TaskDuplicateNameError;
}(Error));
exports.TaskDuplicateNameError = TaskDuplicateNameError;
