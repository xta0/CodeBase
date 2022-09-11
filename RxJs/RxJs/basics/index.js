"use strict";
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
