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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TaskGraph = void 0;
var p_graph_1 = __importDefault(require("p-graph"));
var errors_1 = require("./errors");
var TaskBase_1 = require("./TaskBase");
var Task_1 = require("./Task");
var noop_stream_1 = require("noop-stream");
var stream_1 = require("stream");
var util_1 = require("util");
var pPipeline = (0, util_1.promisify)(stream_1.pipeline);
////////////////////////////////////////////////////////////////////////////////
/**
 * A TaskGraph is an asynchronous task composed of smaller tasks. These sub-tasks
 * are related through a dependency graph, allowing some to run in parallel while
 * requiring strict sequencing between others.
 *
 * @deprecated Use PtyWithInterruptibleChildren or runMultiChildTask instead.
 * They have similar sequencing capabilities, with a simpler API and ability to run
 * in an interactive terminal.
 */
var TaskGraph = /** @class */ (function (_super) {
    __extends(TaskGraph, _super);
    ///// Public /////
    function TaskGraph(parameters, nodes) {
        var _this = _super.call(this, parameters) || this;
        _this._liveLogStreamCount = 0;
        _this._bufferedLogStreams = [];
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment -- Please fix as you edit this code
        _this._nodes = new Map();
        for (var _i = 0, nodes_1 = nodes; _i < nodes_1.length; _i++) {
            var node = nodes_1[_i];
            if (_this._nodes.has(node.task.name)) {
                throw new errors_1.TaskDuplicateNameError(_this.name, node.task.name);
            }
            _this._nodes.set(node.task.name, node);
        }
        _this._dependencyList = [];
        for (var _a = 0, _b = _this._nodes.entries(); _a < _b.length; _a++) {
            var _c = _b[_a], name = _c[0], node = _c[1];
            for (var _d = 0, _e = node.options.dependencies; _d < _e.length; _d++) {
                var dependency = _e[_d];
                _this._dependencyList.push([dependency.name, name]);
            }
        }
        _this.verifyTaskNames();
        _this.performPGraphChecks();
        _this.performContractChecks();
        _this.setupProgressHandlers();
        _this.setupStatusHandlers();
        return _this;
    }
    TaskGraph.prototype.allTasks = function () {
        var _i, _a, task;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0: return [4 /*yield*/, this];
                case 1:
                    _b.sent();
                    _i = 0, _a = this._nodes.values();
                    _b.label = 2;
                case 2:
                    if (!(_i < _a.length)) return [3 /*break*/, 5];
                    task = _a[_i].task;
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
    TaskGraph.prototype.getNestedTasksDownTo = function (name) {
        if (this.name === name) {
            return [this];
        }
        for (var _i = 0, _a = this._nodes.values(); _i < _a.length; _i++) {
            var task = _a[_i].task;
            var trace = task.getNestedTasksDownTo(name);
            if (trace) {
                trace.unshift(this);
                return trace;
            }
        }
        return null;
    };
    TaskGraph.prototype.verifyTaskNames = function () {
        var names = new Set([this.name]);
        for (var _i = 0, _a = this._nodes.values(); _i < _a.length; _i++) {
            var task = _a[_i].task;
            for (var _b = 0, _c = task.verifyTaskNames(); _b < _c.length; _b++) {
                var name = _c[_b];
                if (names.has(name)) {
                    throw new errors_1.TaskDuplicateNameError(this.name, name);
                }
                names.add(name);
            }
        }
        return names;
    };
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskGraph.prototype.execute = function (context, options) {
        return __awaiter(this, void 0, void 0, function () {
            var nodeMap;
            var _this = this;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        nodeMap = new Map(__spreadArray([], this._nodes.entries(), true).map(function (_a) {
                            var name = _a[0], node = _a[1];
                            return [
                                name,
                                {
                                    run: function () { return __awaiter(_this, void 0, void 0, function () {
                                        var _a;
                                        return __generator(this, function (_b) {
                                            switch (_b.label) {
                                                case 0: 
                                                // When cancelled, prevent running any further tasks in the graph
                                                // if (options.cancellationToken?.token.isCancellationRequested) {
                                                //   throw new Error('Cancelled');
                                                // }
                                                // Note: The `node.task.run` function will ensure that the
                                                // required keys are actually defined. This is not something
                                                // TypeScript can guarantee for a node in a complex dependency
                                                // graph, so we use 'as' here to assume the more specific type.
                                                return [4 /*yield*/, node.task.run(context, (_a = {},
                                                        _a[TaskBase_1.parentRunId] = options.runId,
                                                        _a.logStream = this.setupLogStreamForNode(node, options.logStream),
                                                        _a.cancellationToken = options.cancellationToken,
                                                        _a))];
                                                case 1:
                                                    // When cancelled, prevent running any further tasks in the graph
                                                    // if (options.cancellationToken?.token.isCancellationRequested) {
                                                    //   throw new Error('Cancelled');
                                                    // }
                                                    // Note: The `node.task.run` function will ensure that the
                                                    // required keys are actually defined. This is not something
                                                    // TypeScript can guarantee for a node in a complex dependency
                                                    // graph, so we use 'as' here to assume the more specific type.
                                                    _b.sent();
                                                    return [4 /*yield*/, this.flushBufferedStreams(options.logStream)];
                                                case 2:
                                                    _b.sent();
                                                    return [2 /*return*/];
                                            }
                                        });
                                    }); },
                                },
                            ];
                        }));
                        return [4 /*yield*/, (0, p_graph_1.default)(nodeMap, this._dependencyList).run()];
                    case 1:
                        _a.sent();
                        return [4 /*yield*/, this.flushBufferedStreams(options.logStream)];
                    case 2:
                        _a.sent();
                        return [2 /*return*/];
                }
            });
        });
    };
    /**
     * Detect cycles, unknown dependencies and other bad conditions
     * checked by the pGraph function.
     */
    TaskGraph.prototype.performPGraphChecks = function () {
        try {
            // eslint-disable-next-line @typescript-eslint/no-empty-function -- Please fix as you edit this code
            var dummyNodes = new Map(__spreadArray([], this._nodes.keys(), true).map(function (name) { return [name, { run: function () {
                        return __awaiter(this, void 0, void 0, function () { return __generator(this, function (_a) {
                            return [2 /*return*/];
                        }); });
                    } }]; }));
            (0, p_graph_1.default)(dummyNodes, this._dependencyList);
        }
        catch (error) {
            // eslint-disable-next-line @typescript-eslint/no-unsafe-argument -- Please fix as you edit this code
            throw new errors_1.TaskPGraphBuildtimeError(error);
        }
    };
    /**
     * Detect inconsistencies between the `expectsFields` and `assignsFields`
     * contracts of this TaskGraph itself and the Tasks inside it using a DFS traversal.
     */
    TaskGraph.prototype.performContractChecks = function () {
        var _this = this;
        var fieldsAfter = {
            _initial_: new Set(this.expectedFields),
        };
        var processFieldsFor = function (name) {
            if (!(name in fieldsAfter)) {
                // eslint-disable-next-line @typescript-eslint/no-non-null-assertion -- Please fix as you edit this code
                var node = _this._nodes.get(name);
                var fieldsBefore = new Set(fieldsAfter._initial_);
                for (var _i = 0, _a = node.options.dependencies; _i < _a.length; _i++) {
                    var dependency = _a[_i];
                    processFieldsFor(dependency.name);
                    for (var _b = 0, _c = fieldsAfter[dependency.name]; _b < _c.length; _b++) {
                        var key = _c[_b];
                        fieldsBefore.add(key);
                    }
                }
                var fieldsMissingBefore = new Set(node.task.expectedFields);
                for (var _d = 0, fieldsBefore_1 = fieldsBefore; _d < fieldsBefore_1.length; _d++) {
                    var field = fieldsBefore_1[_d];
                    fieldsMissingBefore.delete(field);
                }
                if (fieldsMissingBefore.size > 0) {
                    throw new errors_1.TaskBuildtimePreconditionFailure(node.task.name, __spreadArray([], fieldsMissingBefore, true));
                }
                fieldsAfter[name] = fieldsBefore;
                for (var _e = 0, _f = node.task.assignedFields; _e < _f.length; _e++) {
                    var field = _f[_e];
                    fieldsAfter[name].add(field);
                }
            }
        };
        var fieldsNotAssigned = new Set(this.assignedFields);
        for (var _i = 0, _a = this._nodes.keys(); _i < _a.length; _i++) {
            var name = _a[_i];
            processFieldsFor(name);
            for (var _b = 0, _c = fieldsAfter[name]; _b < _c.length; _b++) {
                var field = _c[_b];
                fieldsNotAssigned.delete(field);
            }
        }
        if (fieldsNotAssigned.size > 0) {
            throw new errors_1.TaskBuildtimePostconditionFailure(this.name, __spreadArray([], fieldsNotAssigned, true));
        }
    };
    TaskGraph.prototype.setupProgressHandlers = function () {
        var _this = this;
        var totalWeight = 0.0;
        for (var _i = 0, _a = this._nodes.values(); _i < _a.length; _i++) {
            var node = _a[_i];
            totalWeight += node.options.progressWeight;
        }
        for (var _b = 0, _c = this._nodes.values(); _b < _c.length; _b++) {
            var node = _c[_b];
            node.on('progressUpdate', function () {
                var totalWeightedProgress = 0.0;
                for (var _i = 0, _a = _this._nodes.values(); _i < _a.length; _i++) {
                    var weightedProgress = _a[_i].weightedProgress;
                    totalWeightedProgress += weightedProgress;
                }
                _this.setProgress(totalWeightedProgress / totalWeight);
            });
        }
    };
    TaskGraph.prototype.setupStatusHandlers = function () {
        var _this = this;
        for (var _i = 0, _a = this._nodes.values(); _i < _a.length; _i++) {
            var node = _a[_i];
            node.task.on('status', function (status) {
                _this.setStatus(status);
            });
        }
    };
    TaskGraph.prototype.setupLogStreamForNode = function (node, logStream) {
        var _this = this;
        switch (node.options.logStreamMode) {
            case 'discard':
                return (0, noop_stream_1.writableNoopStream)();
            case 'live': {
                // We pass a PassThrough instead of the logStream itself to prevent
                // an 'end' signal in the subtask from being propagated.
                var logStreamProxy_1 = new stream_1.PassThrough();
                logStreamProxy_1.pipe(logStream, { end: false });
                this._liveLogStreamCount++;
                node.task.once('end', function () {
                    logStreamProxy_1.end();
                    _this._liveLogStreamCount--;
                });
                // Add event listeners to original (non-proxy) logStream.
                // This allows us to listen with `logStreamProxy.on('event', ...)` and
                // still run `logStream.emit('event', ...)` to trigger it.
                logStreamProxy_1.on = function () {
                    var args = [];
                    for (var _i = 0; _i < arguments.length; _i++) {
                        args[_i] = arguments[_i];
                    }
                    logStream.on.apply(logStream, args);
                    return logStreamProxy_1;
                };
                return logStreamProxy_1;
            }
            case 'buffer': {
                //
                var bufferedLogStream_1 = new stream_1.PassThrough();
                node.task.once('end', function () {
                    _this._bufferedLogStreams.push(bufferedLogStream_1);
                });
                return bufferedLogStream_1;
            }
        }
    };
    TaskGraph.prototype.flushBufferedStreams = function (logStream) {
        return __awaiter(this, void 0, void 0, function () {
            var _i, _a, bufferedLogStream, receiver, promise;
            return __generator(this, function (_b) {
                switch (_b.label) {
                    case 0:
                        if (!(this._liveLogStreamCount === 0)) return [3 /*break*/, 4];
                        _i = 0, _a = this._bufferedLogStreams;
                        _b.label = 1;
                    case 1:
                        if (!(_i < _a.length)) return [3 /*break*/, 4];
                        bufferedLogStream = _a[_i];
                        receiver = new stream_1.PassThrough();
                        receiver.pipe(logStream, { end: false });
                        promise = pPipeline(bufferedLogStream, receiver);
                        bufferedLogStream.end();
                        // eslint-disable-next-line no-await-in-loop
                        return [4 /*yield*/, promise];
                    case 2:
                        // eslint-disable-next-line no-await-in-loop
                        _b.sent();
                        _b.label = 3;
                    case 3:
                        _i++;
                        return [3 /*break*/, 1];
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
    return TaskGraph;
}(Task_1.Task));
exports.TaskGraph = TaskGraph;
