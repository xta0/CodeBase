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
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
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
Object.defineProperty(exports, "__esModule", { value: true });
exports.Task = void 0;
var TaskBase_1 = require("./TaskBase");
var TaskGraphNode_1 = require("./TaskGraphNode");
var noop_stream_1 = require("noop-stream");
var TaskBase_2 = require("./TaskBase");
////////////////////////////////////////////////////////////////////////////////
/**
 * A Task represents an asynchronous operation performed by this module.
 * It can be either a simple step or a dependency graph of sub-tasks,
 * depending on the instantiated subclass (the 'Composite' design pattern).
 */
var Task = /** @class */ (function (_super) {
    __extends(Task, _super);
    ///// Task Setup /////
    function Task(parameters) {
        var _this = this;
        var _a, _b;
        _this = _super.call(this, parameters) || this;
        _this._expectedFields = (_a = parameters.expectsFields) !== null && _a !== void 0 ? _a : [];
        _this._assignedFields = (_b = parameters.assignsFields) !== null && _b !== void 0 ? _b : [];
        return _this;
    }
    /**
     * If this task is to be used as part of a task graph, a call to this function can be used
     * to represent both this task and some options relevant in the context of that graph.
     * @param options.dependencies the other tasks in the graph that need to be run before this one
     * @param options.progressWeight the weight this task's progress should have in the overall
     *                               progress of the graph
     * @returns an object to be used as part of a task-graph specification
     */
    Task.prototype.options = function (options) {
        return new TaskGraphNode_1.TaskGraphNode(this, options);
    };
    /**
     * If this task is to be used as part of a task graph, a call to this function can be used
     * to represent both this task and its dependencies in that graph.
     * You can use this instead of the `options` method in case there are no other options.
     * @param dependencies the other tasks in the graph that need to be run before this one
     * @returns an object to be used as part of a task-graph specification
     */
    Task.prototype.runAfter = function () {
        var dependencies = [];
        for (var _i = 0; _i < arguments.length; _i++) {
            dependencies[_i] = arguments[_i];
        }
        return this.options({ dependencies: dependencies });
    };
    ///// Task Running /////
    /**
     * Run this task in the given context with the given options.
     * @sealed
     */
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    Task.prototype.run = function (context, options) {
        var _a;
        if (options === void 0) { options = {}; }
        return __awaiter(this, void 0, void 0, function () {
            var runId, logStream, startTime, startRunSummary, returnValue, executeOptions, endTime, duration, summary, error_1, endTime, duration, errorSummary;
            return __generator(this, function (_b) {
                switch (_b.label) {
                    case 0:
                        runId = "";
                        logStream = (_a = options.logStream) !== null && _a !== void 0 ? _a : (0, noop_stream_1.writableNoopStream)();
                        startTime = performance.now();
                        startRunSummary = __assign(__assign({}, options), { runId: runId, logStream: logStream, parentRunId: options[TaskBase_2.parentRunId], context: context, startTime: startTime });
                        this.emit('start', startRunSummary);
                        this.setProgress(0.0);
                        _b.label = 1;
                    case 1:
                        _b.trys.push([1, 3, , 4]);
                        executeOptions = __assign({ runId: runId, logStream: logStream }, options);
                        return [4 /*yield*/, this.execute(context, executeOptions)];
                    case 2:
                        // eslint-disable-next-line prefer-const -- Please fix as you edit this code
                        returnValue = _b.sent();
                        this.postcondition(context);
                        this.setProgress(1.0);
                        endTime = performance.now();
                        duration = Math.round(endTime - startTime);
                        summary = __assign(__assign(__assign({}, startRunSummary), { endTime: endTime, duration: duration }), returnValue);
                        this.emit('end', summary);
                        if (this.logToChronicle) {
                            // const params = this.chronicleParams(summary, context);
                            // globalChronicle.logEvent(this.chronicleEvent, {isHumanTriggered: true, ...params});
                        }
                        return [3 /*break*/, 4];
                    case 3:
                        error_1 = _b.sent();
                        endTime = performance.now();
                        duration = Math.round(endTime - startTime);
                        errorSummary = __assign(__assign({}, startRunSummary), { endTime: endTime, duration: duration, 
                            // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment -- Please fix as you edit this code
                            error: error_1 });
                        // Emit error signal, but prevent it from crashing process by adding empty listener.
                        // We only want it for cross-cutting concerns like logging, and the error still
                        // needs to be dealt with anyway because we're rethrowing it.
                        // eslint-disable-next-line @typescript-eslint/no-empty-function -- Please fix as you edit this code
                        this.once('error', function () { });
                        this.emit('error', errorSummary);
                        if (this.logToChronicle) {
                            // const params = this.chronicleErrorParams(errorSummary, context);
                            // globalChronicle.logError(this.chronicleEvent, {isHumanTriggered: true, ...params});
                        }
                        throw error_1;
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
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
    Task.prototype.postcondition = function (context) {
        var missingFields = this.assignedFields.filter(function (key) { return !(key in context && context[key] !== undefined); });
        if (missingFields.length > 0) {
            // throw new TaskPostconditionFailure(this.name, missingFields);
        }
    };
    Object.defineProperty(Task.prototype, "expectedFields", {
        ///// Getters /////
        // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
        get: function () {
            return this._expectedFields;
        },
        enumerable: false,
        configurable: true
    });
    Object.defineProperty(Task.prototype, "assignedFields", {
        // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
        get: function () {
            return this._assignedFields;
        },
        enumerable: false,
        configurable: true
    });
    return Task;
}(TaskBase_1.TaskBase));
exports.Task = Task;
