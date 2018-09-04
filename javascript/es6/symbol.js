
//create a symbol
let s = Symbol();
console.log(typeof s) // "symbol"

//create a symbol with string
let sym = Symbol("foo")
console.log(sym) //"Symbol(foo)"

//symbol function
const key1 = Symbol('greet');
const key2 = Symbol('greet');
let person = {
    name: "James"
}
person[key1] = function(){
    return this.name
}
person[key2] = function(msg){
    return msg
}
console.log(person[key1]())
console.log(person[key2]("Some Message"))
console.log(Object.keys(person ))
console.log(Object.getOwnPropertySymbols(person));

//sysmbol function in class
class Some_Class{
    constructor(name){
        this.name = name;
    }
    [Symbol('greet')](){
        return this.name;
    }
    [Symbol('greet')](msg){
        return msg;
    }
}

