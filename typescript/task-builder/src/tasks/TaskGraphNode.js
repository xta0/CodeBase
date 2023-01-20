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
Object.defineProperty(exports, "__esModule", { value: true });
exports.TaskGraphNode = void 0;
var events_1 = require("events");
////////////////////////////////////////////////////////////////////////////////
/**
 * Represents a node in a TaskGraph instance, wrapping a Task.
 */
var TaskGraphNode = /** @class */ (function (_super) {
    __extends(TaskGraphNode, _super);
    function TaskGraphNode(task, options) {
        if (options === void 0) { options = {}; }
        var _this = _super.call(this) || this;
        _this.task = task;
        _this.options = __assign({ dependencies: [], progressWeight: 1, logStreamMode: 'live' }, options);
        _this.weightedProgress = 0.0;
        task.on('progress', function (progress) {
            _this.weightedProgress = _this.options.progressWeight * progress;
            _this.emit('progressUpdate');
        });
        return _this;
    }
    return TaskGraphNode;
}(events_1.EventEmitter));
exports.TaskGraphNode = TaskGraphNode;
