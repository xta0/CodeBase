## Setup
- create index.html
- create app.js
- create app.ts
    - tsc app.ts
- npm install --save-dev lite-server
    - "start": "lite-server"
- watch mode
    - `tsc app.ts -w`

## Primitive Typs

- number
- boolean
- string
- tupe: `[number, string]`
- enum:  `enum { A, B , C}`
- array: `string[]`
- union: `number | string`
- literal: 'as-number'
- object:

```
const person: {
    name: String
} = {
    name: "XYZ"
}

```


- type alias
    - `type new_type = number | string`
    - `type User = {name: String; age: number}`
        - `const u1: User = {name: 'Max', age: 30}`
- function types
    - `function f(n:number): number{ return n; }`
    - `let f: Function`
    - `let f: () => number`
- unknown type
    - `let userInput: unknown`
    - `unknown` is different from `any`. Before using the unknow var, we have to check type first
- never type
    - For functions that throws errors