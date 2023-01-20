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
exports.TaskStep = void 0;
var Task_1 = require("./Task");
////////////////////////////////////////////////////////////////////////////////
/**
 * A TaskStep represents a single asynchronous step defined by an asynchronous function.
 * More complex tasks can be defined by putting these inside a TaskGraph.
 *
 * @deprecated Use PtyWithInterruptibleChildren or runMultiChildTask instead.
 * They have similar sequencing capabilities, with a simpler API and ability to run
 * in an interactive terminal.
 */
var TaskStep = /** @class */ (function (_super) {
    __extends(TaskStep, _super);
    ///// Public /////
    function TaskStep(parameters, stepFunction) {
        var _this = _super.call(this, parameters) || this;
        _this._stepFunction = stepFunction;
        return _this;
    }
    TaskStep.prototype.allTasks = function () {
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, this];
                case 1:
                    _a.sent();
                    return [2 /*return*/];
            }
        });
    };
    ///// Protected /////
    TaskStep.prototype.getNestedTasksDownTo = function (name) {
        return this.name === name ? [this] : null;
    };
    TaskStep.prototype.verifyTaskNames = function () {
        return new Set([this.name]);
    };
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types -- Please fix as you edit this code
    TaskStep.prototype.execute = function (context, options) {
        var _this = this;
        return this._stepFunction(context, {
            reportProgress: function (progress) {
                // clamping between 0.0 and 1.0
                _this.setProgress(Math.max(0.0, Math.min(1.0, progress)));
            },
            reportStatus: function (status) {
                _this.setStatus(status);
            },
            logStream: options.logStream,
            cancellationToken: options.cancellationToken,
        });
    };
    return TaskStep;
}(Task_1.Task));
exports.TaskStep = TaskStep;
