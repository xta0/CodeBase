"use strict";
/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */
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
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
var __values = (this && this.__values) || function(o) {
    var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
    if (m) return m.call(o);
    if (o && typeof o.length === "number") return {
        next: function () {
            if (o && i >= o.length) o = void 0;
            return { value: o && o[i++], done: !o };
        }
    };
    throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TaskDecider = void 0;
var errors_1 = require("./errors");
var TaskBase_1 = require("./TaskBase");
var Task_1 = require("./Task");
////////////////////////////////////////////////////////////////////////////////
/**
 * A TaskDecider allows writing custom logic to decide which of a set of
 * predeclared subtasks is run, and possibly to catch and handle exceptions
 * thrown from tasks.
 *
 * Note: Only use this if necessary. Typescript cannot always guarantee
 * type safety w.r.t. assignedFields.
 */
var TaskDecider = /** @class */ (function (_super) {
    __extends(TaskDecider, _super);
    ///// Public /////
    function TaskDecider(parameters, candidateTasks, deciderFunction) {
        var _this = _super.call(this, parameters) || this;
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment -- Please fix as you edit this code
        _this._candidates = new Map();
        for (var _i = 0, candidateTasks_1 = candidateTasks; _i < candidateTasks_1.length; _i++) {
            var task = candidateTasks_1[_i];
            if (_this._candidates.has(task.name)) {
                throw new errors_1.TaskDuplicateNameError(_this.name, task.name);
            }
            _this._candidates.set(task.name, task);
        }
        _this._deciderFunction = deciderFunction;
        _this.verifyTaskNames();
        _this.performContractChecks();
        return _this;
    }
    TaskDecider.prototype.allTasks = function () {
        var _i, _a, task;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0: return [4 /*yield*/, this];
                case 1:
                    _b.sent();
                    _i = 0, _a = this._candidates.values();
                    _b.label = 2;
                case 2:
                    if (!(_i < _a.length)) return [3 /*break*/, 5];
                    task = _a[_i];
                    return [5 /*yield**/, __values(task.allTasks())];
                case 3:
                    _b.sent();
                    _b.label = 4;
                case 4:
                    _i++;
                    return [3 /*break*/, 2];
                case 5: return [2 /*return*/];
            }
        });
    };
    ///// Protected /////
    TaskDecider.prototype.getNestedTasksDownTo = function (name) {
        if (this.name === name) {
            return [this];
        }
        for (var _i = 0, _a = this._candidates.values(); _i < _a.length; _i++) {
            var task = _a[_i];
            var trace = task.getNestedTasksDownTo(name);
            if (trace) {
                trace.unshift(this);
                return trace;
            }
        }
        return null;
    };
    TaskDecider.prototype.verifyTaskNames = function () {
        var names = new Set([this.name]);
        for (var _i = 0, _a = this._candidates.values(); _i < _a.length; _i++) {
            var task = _a[_i];
            for (var _b = 0, _c = task.verifyTaskNames(); _b < _c.length; _b++) {
                var name_1 = _c[_b];
                if (names.has(name_1)) {
                    throw new errors_1.TaskDuplicateNameError(this.name, name_1);
                }
                names.add(name_1);
            }
        }
        return names;
    };
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskDecider.prototype.execute = function (context, options) {
        return __awaiter(this, void 0, void 0, function () {
            var subtasksInvoked, subtaskIsSettled, taskRunners, _loop_1, _i, _a, task;
            var _this = this;
            return __generator(this, function (_b) {
                switch (_b.label) {
                    case 0:
                        subtasksInvoked = [];
                        subtaskIsSettled = false;
                        taskRunners = {};
                        _loop_1 = function (task) {
                            taskRunners[task.name] = function () { return __awaiter(_this, void 0, void 0, function () {
                                var _a;
                                return __generator(this, function (_b) {
                                    switch (_b.label) {
                                        case 0:
                                            subtasksInvoked.push(task.name);
                                            if (!(subtasksInvoked.length === 1)) return [3 /*break*/, 4];
                                            _b.label = 1;
                                        case 1:
                                            _b.trys.push([1, , 3, 4]);
                                            return [4 /*yield*/, task.run(context, (_a = {},
                                                    _a[TaskBase_1.parentRunId] = options.runId,
                                                    _a.logStream = options.logStream,
                                                    _a))];
                                        case 2:
                                            _b.sent();
                                            return [3 /*break*/, 4];
                                        case 3:
                                            subtaskIsSettled = true;
                                            return [7 /*endfinally*/];
                                        case 4: return [2 /*return*/];
                                    }
                                });
                            }); };
                        };
                        for (_i = 0, _a = this._candidates.values(); _i < _a.length; _i++) {
                            task = _a[_i];
                            _loop_1(task);
                        }
                        // Run decider function
                        return [4 /*yield*/, this._deciderFunction(context, taskRunners)];
                    case 1:
                        // Run decider function
                        _b.sent();
                        // Throw if more than one subtask was invoked
                        if (subtasksInvoked.length > 1) {
                            throw new errors_1.MultipleDeciderTasksInvokedError(this.name, subtasksInvoked);
                        }
                        // Throw if the decider function settles before the subtask runner does.
                        // (i.e., if the subtask promise was not awaited inside the decider function)
                        if (subtasksInvoked.length > 0 && !subtaskIsSettled) {
                            throw new errors_1.SubtaskNotAwaitedError(this.name, subtasksInvoked[0]);
                        }
                        return [2 /*return*/];
                }
            });
        });
    };
    /**
     * Detect subtasks that cannot satisfy the `assignsFields` guarantees of this task.
     */
    TaskDecider.prototype.performContractChecks = function () {
        var fieldsNotAssigned = new Set();
        var _loop_2 = function (aName) {
            if (!__spreadArray([], this_1._candidates.values(), true).every(function (task) {
                return task.assignedFields.some(function (subAName) { return subAName === aName; });
            })) {
                fieldsNotAssigned.add(aName);
            }
        };
        var this_1 = this;
        for (var _i = 0, _a = this.assignedFields; _i < _a.length; _i++) {
            var aName = _a[_i];
            _loop_2(aName);
        }
        if (fieldsNotAssigned.size > 0) {
            throw new errors_1.TaskBuildtimePostconditionFailure(this.name, __spreadArray([], fieldsNotAssigned, true));
        }
    };
    return TaskDecider;
}(Task_1.Task));
exports.TaskDecider = TaskDecider;
