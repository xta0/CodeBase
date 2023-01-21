///////////////////////////////////////////////////////////

import { resolveModuleName } from "typescript";

// built-in generics
const names:Array<string> = [];
const promise: Promise<string> = new Promise( resolve => {
    setTimeout (() => {
        resolve('11000')
    }, 2000)
})
promise.then(data => data.split(' '))
