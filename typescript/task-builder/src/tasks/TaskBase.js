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
exports.TaskBase = exports.parentRunId = exports.defaultChronicleError = void 0;
var events_1 = require("events");
var errors_1 = require("./errors");
exports.defaultChronicleError = 'FBTaskRunnerError';
exports.parentRunId = Symbol('parentRunId');
var TaskBase = /** @class */ (function (_super) {
    __extends(TaskBase, _super);
    function TaskBase(parameters) {
        var _this = _super.call(this) || this;
        _this.name = parameters.name;
        _this.chronicleEvent =
            'chronicleEvent' in parameters ? parameters.chronicleEvent : parameters.name;
        _this.chronicleErrorCode = parameters.chronicleErrorCode
            ? parameters.chronicleErrorCode
            : exports.defaultChronicleError;
        _this.logToChronicle = parameters.logToChronicle === true;
        return _this;
    }
    /**
 * Get a task by name, however deeply nested under this task.
 * @param task the name of the task you're requesting (or the task itself)
 * @returns the task with the given name, or `null` if no such task exists
 */
    TaskBase.prototype.getTask = function (task) {
        var _a, _b;
        if (task instanceof TaskBase) {
            return task;
        }
        else {
            return (_b = (_a = this.getNestedTasksDownTo(task)) === null || _a === void 0 ? void 0 : _a.pop()) !== null && _b !== void 0 ? _b : null;
        }
    };
    TaskBase.prototype.taskSpan = function (from, fromEvent, to, toEvent, callback) {
        var _this = this;
        var fromTask = this.getTask(from);
        var toTask = this.getTask(to);
        if (!fromTask || !toTask) {
            return;
        }
        var toEventFired = false;
        toTask.once(toEvent, function () {
            toEventFired = true;
        });
        fromTask.once(fromEvent, function (fromSummary) {
            // don't invoke callback if the `to` event already fired
            if (toEventFired) {
                return;
            }
            var toSummaryPromise = new Promise(function (resolve, reject) {
                // resolve when the 'to' event fires
                toTask.once(toEvent, resolve);
                // reject if any task inbetween fails (which should propagate to this task)
                _this.once('error', function (errorSummary) {
                    reject(errorSummary.error);
                });
                // reject if this task ends without the `to` event ever firing
                _this.once('end', function () {
                    reject(new errors_1.EventsNotSequencedError(fromTask.name, fromEvent, toTask.name, toEvent));
                });
            });
            callback(fromSummary, toSummaryPromise);
        });
    };
    ///// Getters /////
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskBase.prototype.progress = function () {
        var _a;
        return (_a = this._progress) !== null && _a !== void 0 ? _a : 0.0;
    };
    ///// Protected Methods /////
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskBase.prototype.setProgress = function (newProgress) {
        if (this._progress !== newProgress) {
            this._progress = newProgress;
            this.emit('progress', this._progress);
        }
    };
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskBase.prototype.setStatus = function (newStatus) {
        if (this._status !== newStatus) {
            this._status = newStatus;
            this.emit('status', this._status);
        }
    };
    return TaskBase;
}(events_1.EventEmitter));
exports.TaskBase = TaskBase;
