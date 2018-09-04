class Person {
    constructor(name){
        this.name = name;
    }
}
const p = new Person('jayson')
console.log(p.toString());


const digits = [0, 1, 2];
const arrayIterator = digits[Symbol.iterator](); //object
console.log(arrayIterator.next());
console.log(arrayIterator.next());
console.log(arrayIterator.next());
console.log(arrayIterator.next());