import { debounceTime, filter, map, Observable, Subscriber, tap, catchError, EMPTY, concatMap, Subject, BehaviorSubject } from 'rxjs';

// an observable can emit the following notifications
// 1. next  0..many
// 2. error 0..1
// 3. complete 0..1

const foo$ = new Observable<string>(s => {
    s.next('foo')
    setTimeout(()=>s.next('Bar'), 1000)
});

// const observer = {
//     next: value => console.log(value)
// };
// foo$.subscribe(observer);

// instead of passin an observer object, we can pass in a function as the default next function
const sub = foo$.subscribe(value => console.log("sub1 is called: ", value));

// setTimeout(() => {
//     sub.unsubscribe();
// }, 2000);

// a observable can be subscribed multiple times, each subscriber runs independently
const sub2 = foo$.subscribe(value => console.log("sub2 is called: ", value));

console.log("-----------")

// tear down
const obs1$ = new Observable<string>(s => {
    s.next('alice')
    setTimeout(()=>{
        s.next('bob')
        s.complete()
    },1000)
    // tear down function, run after s.complete()
    return () => {
        console.log('obs1$ finsihed!')
    };
});

obs1$.subscribe({
    next: value => console.log(value),
    complete: () => {
        console.log('complete!')
    },
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
import { of } from "rxjs";
console.log('[Creation Operators] - of')
of('Alice', 'Bob').subscribe({
    next: value => console.log(value),
    complete: () => { console.log("completd") },
});

function of_impl(...args: string[]):Observable<string> {
    return new Observable<string>(s => {
        for(let i=0; i<args.length; ++i){
            s.next(args[i])
        }
        s.complete();
    })
}
console.log('------------')

// from([A, B, C])
import { from } from "rxjs";
console.log('[Creation Operators] - from')
from(['Alice', 'Bob']).subscribe({
    next: value => console.log(value),
    complete: () => console.log('Completed!')
});

console.log('------------')


// from(Promise)
const p = new Promise((resolve, reject) => {
    resolve('Resolved!')
})

// fromEvent - the observers never complete unless unsubscribe is called

// timer - fire and end

// forkJoin, combineLatest
// import { ajax } from "rxjs/ajax"
// const A$ = ajax('https: //random-data-api.com/api/name/random_name');
// const B$ = ajax('https: //random-data-api.com/api/nation/random_nation');
// const C$ = ajax('https: //random-data-api.com/api/nation/random_food');

// A$.subscribe(res => console.log(res.first_name))
// B$.subscribe(res => console.log(res.captial))
// C$.subscribe(res => console.log(res.dish))
// forkJoin(A$, B$, C$).subscribe( a, b, c => { ... })

// Pipeable Operators
interface NewsItem {
    category: 'Business' | 'Sports';
    content: string;
}

const newsFeed$ = new Observable<NewsItem>(s => {
    setTimeout( () => s.next({category: "Business", content: "A"}));
    setTimeout( () => s.next({category: "Sports", content: "B"}))
});

newsFeed$.pipe(
    filter( item => item.category == 'Sports')
).subscribe( item => console.log(item))

// tap - handle side effects in the pipeline. Doesn't affect observable's status
of(1, 2, 3).pipe(
    map(data => data * 2),
    tap(data => console.log(data)),
    filter(data => data > 5)
).subscribe( data => console.log(data))

// debounceTime - avoid frequent callbacks (slidebar, searchbar, etc)
// delay 1s and output the latest event
const x$ = new Observable<string>(s => {
    s.next('skip A')
    s.next('Hit B')
});
x$.pipe(debounceTime(1000)).subscribe(val => console.log(val))



// catchError - provide the fallback observable in case the orignal observable failed
const y1$ = new Observable<string>(s => {
    setTimeout( () => {s.error('y1 is hitting an error!')} , 1000)
});
y1$.pipe( catchError(err => of("Fallback value"))).subscribe( value => console.log(value))

// use EMPTY observable to silent the error, who emits the complete notification
const y2$ = new Observable<string>(s => {
    setTimeout( () => {s.error('y2 is hitting an error!')} , 1000)
});
y1$.pipe( catchError(err => EMPTY)).subscribe( {
    next: value => console.log(value),
    complete: () => console.log("y2 completes!")
})

console.log('------concatMap------')
// concatMap
const src1$ = new Observable( s => {
    setTimeout( () => s.next('a1'), 1000);
    setTimeout( () => s.next('a2'), 2000);
});
// map src1 to another observable, when src1$ gets subscribed
src1$.pipe(
    concatMap( value => of(value))
).subscribe({
    next: value => console.log(value),
    complete: () => console.log('src1 complete')
})
// it can also be used to chain observables
const src2$ = new Observable( s => {
    s.next('b')
});
src2$.pipe(
    map( v => v + '1'),
    concatMap( v => of(v, v))
).subscribe({
    next: data => console.log(data),
    complete: () => console.log('src2 complete')
})

// catch error in the mapped inner observable, so the outer observable can still react to events
const src3_err = new Observable ( s => {
    s.error('src_error')
});
src2$.pipe(
    map( v => v + '1'),
    concatMap( v => src3_err.pipe(
        // catchError ( v => EMPTY) // turn error to a complete notificaiton, but don't emit
        catchError ( err => of('src3 failed')) // turn error to a complete notificaiton, but don't emit
    ))
).subscribe({
    // observer receive nothing when there is an error
    next: data => console.log(data),
    error: () => console.log('src2 error'),
    complete: () => console.log('src2 complete')
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

const value$ = new Subject<string>(); // create a subject object
value$.subscribe( val => console.log("sub1: ", val)) // add observers to the subject object
value$.subscribe( val => console.log("sub2: ", val)) // add observers to the subject object
const ob = new Observable<string>( s => {
    s.next('ob is firing')
});
ob.subscribe( data => {
    value$.next(data) // when observerable triggers, broadcast the data to observers
});
// subject can also be used as observer directly.
// ob.subscribe(value$)

// BehaviorSubject
// BahaviorSubject stores the broadcasting data to its memory. When a new subscriber comes, it emits the cached data
const state$ = new BehaviorSubject<boolean>(false);
state$.subscribe( val => console.log("state: ", val))
const loginBtn$ = new Observable<boolean>( s => {
    s.next(true)
});
loginBtn$.subscribe(state$)

const logoutBtn$ = new Observable<boolean>( s => {
    s.next(false);
});
logoutBtn$.subscribe(state$)

