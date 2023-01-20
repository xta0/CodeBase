var Singleton = /** @class */ (function () {
    function Singleton(platform) {
        this.platform = platform;
        this.paltform = { arch: "Apple" };
    }
    Singleton.getInstance = function (val) {
        if (!Singleton.instance) {
            Singleton.instance = new Singleton(val);
        }
        return Singleton.instance;
    };
    Singleton.prototype.getPlatform = function () {
        console.log(this.paltform);
    };
    return Singleton;
}());
var xx = {
    arch: "App"
};
var v = Singleton.getInstance(xx);
v.getPlatform();
