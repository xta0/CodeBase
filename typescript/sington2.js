"use strict";
exports.__esModule = true;
exports.Singleton = void 0;
var Singleton;
(function (Singleton) {
    function hello() {
        console.log("hello");
    }
    Singleton.hello = hello;
})(Singleton = exports.Singleton || (exports.Singleton = {}));
Singleton.hello();
