import { Observable, Subscriber } from 'rxjs';  

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