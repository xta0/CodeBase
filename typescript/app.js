var NAME;
(function (NAME) {
    var IOSPlatform = /** @class */ (function () {
        function IOSPlatform(platform) {
            this.platform = platform;
        }
        IOSPlatform.prototype.prepare = function (context) {
            return this.platform.prepare(context);
        };
        IOSPlatform.prototype.launch = function (context) {
            return this.platform.launch(context);
        };
        IOSPlatform.prototype.postprocess = function (context) {
            return this.platform.postprocess(context);
        };
        return IOSPlatform;
    }());
    var IPhoneSimulatorPlatform = /** @class */ (function () {
        function IPhoneSimulatorPlatform(buckState) {
            this.buckState = buckState;
        }
        IPhoneSimulatorPlatform.prototype.archType = function () {
            return 'ios-sim';
        };
        IPhoneSimulatorPlatform.prototype.prepare = function (context) {
            console.log("".concat(this.archType().toString(), " : prepare"));
            return Promise.resolve(void 0);
        };
        IPhoneSimulatorPlatform.prototype.launch = function (context) {
            return Promise.resolve(void 0);
        };
        IPhoneSimulatorPlatform.prototype.postprocess = function (context) {
            return Promise.resolve(void 0);
        };
        return IPhoneSimulatorPlatform;
    }());
    var IPhoneDevicePlatform = /** @class */ (function () {
        function IPhoneDevicePlatform(buckState) {
            this.buckState = buckState;
        }
        IPhoneDevicePlatform.prototype.archType = function () {
            return 'ios-device';
        };
        IPhoneDevicePlatform.prototype.supportedActions = function (context) {
        };
        IPhoneDevicePlatform.prototype.buckMode = function (context) {
            return [];
        };
        IPhoneDevicePlatform.prototype.prepare = function (context) {
            console.log("".concat(this.archType().toString(), " : prepare"));
            return Promise.resolve(void 0);
        };
        IPhoneDevicePlatform.prototype.launch = function (context) {
            return Promise.resolve(void 0);
        };
        IPhoneDevicePlatform.prototype.postprocess = function (context) {
            return Promise.resolve(void 0);
        };
        return IPhoneDevicePlatform;
    }());
    function ApplePlatfromFactory(platformName, state) {
        var platformImpl = new platformName(state);
        return new IOSPlatform(platformImpl);
    }
    var buckState = {
        version: "buck1"
    };
    var context = {
        buckState: buckState
    };
    var iOSPlatfrom = ApplePlatfromFactory(IPhoneSimulatorPlatform, buckState);
    iOSPlatfrom.prepare(context);
    var PLATFORM_CLASS = {
        'bundle_ios-sim': IPhoneSimulatorPlatform,
        'bundle_ios-device': IPhoneDevicePlatform
    };
})(NAME || (NAME = {}));
