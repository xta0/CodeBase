let promise = new Promise((resolved, reject)=>{
    reject();
})
console.log(promise)
promise.then(()=>{
    console.log('finally finished')

}).then(()=>{
    console.log('also ran')
})
promise.catch(()=>{
    console.log('uh oh')
})

const url = "https://jsonplaceholder.typicode.com/posts/"