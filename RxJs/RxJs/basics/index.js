"use strict";
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
        while (_) try {
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
exports.__esModule = true;
var rxjs_1 = require("rxjs");
// an observable can emit the following notifications
// 1. next  0..many
// 2. error 0..1
// 3. complete 0..1
var foo$ = new rxjs_1.Observable(function (s) {
    s.next('foo');
    setTimeout(function () { return s.next('Bar'); }, 1000);
});
// const observer = {
//     next: value => console.log(value)
// };
// foo$.subscribe(observer);
// instead of passin an observer object, we can pass in a function as the default next function
var sub = foo$.subscribe(function (value) { return console.log("sub1 is called: ", value); });
// setTimeout(() => {
//     sub.unsubscribe();
// }, 2000);
// a observable can be subscribed multiple times, each subscriber runs independently
var sub2 = foo$.subscribe(function (value) { return console.log("sub2 is called: ", value); });
console.log("-----------");
// tear down
var obs1$ = new rxjs_1.Observable(function (s) {
    s.next('alice');
    setTimeout(function () {
        s.next('bob');
        s.complete();
    }, 1000);
    // tear down function, run after s.complete()
    return function () {
        console.log('obs1$ finsihed!');
    };
});
obs1$.subscribe({
    next: function (value) { return console.log(value); },
    complete: function () {
        console.log('complete!');
    }
});
// cold observable vs hot observable
// 1. code observable : every observer runs independantly, new subscriber, new data
//     - produce a set of values
//     - HTTP requests
//     - Timer/Interval
// 2. hot observable : observers share the same notification. Multicasts the data from a common source
//     - button callback
//     - State
//     - Subjects
// Creation operators
// 1. of(A, B ,C) - fire a set of values and complete
var rxjs_2 = require("rxjs");
console.log('[Creation Operators] - of');
(0, rxjs_2.of)('Alice', 'Bob').subscribe({
    next: function (value) { return console.log(value); },
    complete: function () { console.log("completd"); }
});
function of_impl() {
    var args = [];
    for (var _i = 0; _i < arguments.length; _i++) {
        args[_i] = arguments[_i];
    }
    return new rxjs_1.Observable(function (s) {
        for (var i = 0; i < args.length; ++i) {
            s.next(args[i]);
        }
        s.complete();
    });
}
console.log('------------');
// from([A, B, C])
var rxjs_3 = require("rxjs");
console.log('[Creation Operators] - from');
(0, rxjs_3.from)(['Alice', 'Bob']).subscribe({
    next: function (value) { return console.log(value); },
    complete: function () { return console.log('Completed!'); }
});
console.log('------------');
// from(Promise)
var p = new Promise(function (resolve, reject) {
    resolve('Resolved!');
});
var newsFeed$ = new rxjs_1.Observable(function (s) {
    setTimeout(function () { return s.next({ category: "Business", content: "A" }); });
    setTimeout(function () { return s.next({ category: "Sports", content: "B" }); });
});
newsFeed$.pipe((0, rxjs_1.filter)(function (item) { return item.category == 'Sports'; })).subscribe(function (item) { return console.log(item); });
// tap - handle side effects in the pipeline. Doesn't affect observable's status
(0, rxjs_2.of)(1, 2, 3).pipe((0, rxjs_1.map)(function (data) { return data * 2; }), (0, rxjs_1.tap)(function (data) { return console.log(data); }), (0, rxjs_1.filter)(function (data) { return data > 5; })).subscribe(function (data) { return console.log(data); });
// debounceTime - avoid frequent callbacks (slidebar, searchbar, etc)
// delay 1s and output the latest event
var x$ = new rxjs_1.Observable(function (s) {
    s.next('skip A');
    s.next('Hit B');
});
x$.pipe((0, rxjs_1.debounceTime)(1000)).subscribe(function (val) { return console.log(val); });
// catchError - provide the fallback observable in case the orignal observable failed
var y1$ = new rxjs_1.Observable(function (s) {
    setTimeout(function () { s.error('y1 is hitting an error!'); }, 1000);
});
y1$.pipe((0, rxjs_1.catchError)(function (err) { return (0, rxjs_2.of)("Fallback value"); })).subscribe(function (value) { return console.log(value); });
// use EMPTY observable to silent the error, who emits the complete notification
var y2$ = new rxjs_1.Observable(function (s) {
    setTimeout(function () { s.error('y2 is hitting an error!'); }, 1000);
});
y1$.pipe((0, rxjs_1.catchError)(function (err) { return rxjs_1.EMPTY; })).subscribe({
    next: function (value) { return console.log(value); },
    complete: function () { return console.log("y2 completes!"); }
});
console.log('------concatMap------');
// concatMap
var src1$ = new rxjs_1.Observable(function (s) {
    setTimeout(function () { return s.next('a1'); }, 1000);
    setTimeout(function () { return s.next('a2'); }, 2000);
});
// map src1 to another observable, when src1$ gets subscribed
src1$.pipe((0, rxjs_1.concatMap)(function (value) { return (0, rxjs_2.of)(value); })).subscribe({
    next: function (value) { return console.log(value); },
    complete: function () { return console.log('src1 complete'); }
});
// it can also be used to chain observables
var src2$ = new rxjs_1.Observable(function (s) {
    s.next('b');
});
src2$.pipe((0, rxjs_1.map)(function (v) { return v + '1'; }), (0, rxjs_1.concatMap)(function (v) { return (0, rxjs_2.of)(v, v); })).subscribe({
    next: function (data) { return console.log(data); },
    complete: function () { return console.log('src2 complete'); }
});
// catch error in the mapped inner observable, so the outer observable can still react to events
var src3_err = new rxjs_1.Observable(function (s) {
    s.error('src_error');
});
src2$.pipe((0, rxjs_1.map)(function (v) { return v + '1'; }), (0, rxjs_1.concatMap)(function (v) { return src3_err.pipe(
// catchError ( v => EMPTY) // turn error to a complete notificaiton, but don't emit
(0, rxjs_1.catchError)(function (err) { return (0, rxjs_2.of)('src3 failed'); }) // turn error to a complete notificaiton, but don't emit
); })).subscribe({
    // observer receive nothing when there is an error
    next: function (data) { return console.log(data); },
    error: function () { return console.log('src2 error'); },
    complete: function () { return console.log('src2 complete'); }
});
// concurrency
// 1. if the inner observable is an async func, if there are multiple subscriptions happen at the same time, the concatMap will execute them one by one, this is a nice FIFO queue.
// 2. if we want to cacncel the previous one, use switchMap
// 3. if we want to achieve full concurrency, use mergeMap, but the order is not guanranteed
// concatMap
// - Queues/Buffers, Memory leak easy to notice, Values are handled one by one
// switchMap
// - Cancel / unsubscribes, memory leak not dangerous,quick reaction to new source values, order mostly safe
// mergeMap
// - Concurrent, memeory leaks hard to notice, no definite order
// Subject
// subject is similar to hot observable, which emits notifications to all observers
var value$ = new rxjs_1.Subject(); // create a subject object
value$.subscribe(function (val) { return console.log("sub1: ", val); }); // add observers to the subject object
value$.subscribe(function (val) { return console.log("sub2: ", val); }); // add observers to the subject object
var ob = new rxjs_1.Observable(function (s) {
    s.next('ob is firing');
});
ob.subscribe(function (data) {
    value$.next(data); // when observerable triggers, broadcast the data to observers
});
// subject can also be used as observer directly.
// ob.subscribe(value$)
// BehaviorSubject
// BahaviorSubject stores the broadcasting data to its memory. When a new subscriber comes, it emits the cached data
var state$ = new rxjs_1.BehaviorSubject(false);
state$.subscribe(function (val) { return console.log("state: ", val); });
var loginBtn$ = new rxjs_1.Observable(function (s) {
    s.next(true);
});
loginBtn$.subscribe(state$);
var logoutBtn$ = new rxjs_1.Observable(function (s) {
    s.next(false);
});
logoutBtn$.subscribe(state$);
//merge and concat
(0, rxjs_1.merge)((0, rxjs_2.of)([1, 2, 3]), (0, rxjs_2.of)([2, 3, 4])).subscribe(function (v) {
    console.log("merge triggered: ", v);
});
console.log("---xxxxxxxxxx-----");
var fox$ = new rxjs_1.Observable(function (s) {
    s.next('fox');
    setTimeout(function () { return s.next('fox_1000'); }, 1000);
});
function fun1() {
    return __awaiter(this, void 0, void 0, function () {
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    console.log("func1 is called!");
                    return [4 /*yield*/, fox$.toPromise()];
                case 1: return [2 /*return*/, _a.sent()];
            }
        });
    });
}
(function () { return __awaiter(void 0, void 0, void 0, function () {
    var result;
    return __generator(this, function (_a) {
        switch (_a.label) {
            case 0:
                console.log("async is called!");
                return [4 /*yield*/, fun1()];
            case 1:
                result = _a.sent();
                console.log("result: ", result);
                console.log(result);
                return [2 /*return*/];
        }
    });
}); })();
