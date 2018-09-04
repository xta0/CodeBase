
//create a promise
let promise = new Promise((resolved, reject)=>{
    
})
console.log(promise)

//trigger promise
promise.then(()=>{
    //promise succeed
    console.log('finally finished')

}).then(()=>{
    console.log('also ran')
})
promise.catch(()=>{
    //promise failed
    console.log('uh oh')
})

//promise for network request
const url = "https://jsonplaceholder.typicode.com/posts/"
fetch(url)
    .then( response => response.json() )
    .then( data => console.log(data) );

