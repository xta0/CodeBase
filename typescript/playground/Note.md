
## Setup
- create index.html
- create app.js
- create app.ts
- compile and run
    - `tss-node app.ts`

## Primitive Typs

- number
- boolean
- string
- tupe: `[number, string]`
- enum:  `enum { A, B , C}`
- array: `string[]`
- union: `number | string`
- literal: `type Result = 'result'`
- object
- type alias
- function types
    - `function f(n:number): number{ return n; }`
    - `let f: Function`
    - `let f: () => number`
- unknown type
    - `let userInput: unknown`
    - `unknown` is different from `any`. Before using the unknow var, we have to check type first
- never type
    - For functions that throws errors

## Tell Whether a symbol is in the type space or value space

A symbol in typescript exits in one of two spaces

1. Type space
2. Value space


## Best practice

1. Cannot check typescript types at runtime
    - `instanceof` doesn't work for typescript types