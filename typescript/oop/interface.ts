interface Person {
    name: string;
    readonly age: number;
    greet(phrase: string) : void;
    attack?: Attack
}

interface Attack {
    (opponent: {alias: string; health: number;}, attackWith: number):number
}

let taox : Person = {
    name: 'Tao',
    age: 30,
    greet(phrase: string) {
        console.log(phrase + ' ' + this.name)
    }
};
taox.greet('hello!')

class SuperHero implements Person {
    name: string;
    age: number;
    greet(phrase: string) {
        console.log(phrase + ' ' + this.name)
    }
}

////////////////////////////////////////////////////////////////////
interface IPet {
    name: string;
    age: number;
    favoriatePark? :string;
}

// remove all the optional types from IPet
// add readonly to all the types
type ReadonlyPet = {
    +readonly [k in keyof IPet]-?: IPet[k];
}

const pet:IPet = {name: 'Buttons', age: 5};
const pet2:ReadonlyPet = {name: 'Buttons', age: 5};
// pet2.name = 'x' //error

////////////////////////////////////////////////////////////////////
// interface as function types

// type AddFn = (a: number, b: number) => number
interface AddFn {
    (a: number, b:number): number
}
const add:AddFn = (n1: number, n2:number) => {
    return n1+n2
}

////////////////////////////////////////////////////////////////////
// index property

// the error object could be
// 1. { email: string, username: string}
// 2. { email: string}
// 3. { username: string}
// 4. { other1: string, other2: number}
interface ErrorContainer {
    // i don't know the property name, but the type has to be string
    [prop: string]: string;
}

const errorBag: ErrorContainer = {
    email: 'abc',
    1: "123" // 1 can be parsed as string
}
