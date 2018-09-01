function fun1(name){
    console.log(name)
}
console.log("fun1: ", fun1.__proto__ , typeof(fun1.__proto__))
console.log("fun1: ", fun1.prototype, typeof(fun1.prototype))

function fun3(name){
    this.name = name;
}
console.log("fun3_before: ",fun3.__proto__ , typeof(fun3.__proto__))
console.log("fun3_before: ", fun3.prototype, typeof(fun3.prototype))

var obj = new fun3("John")

console.log("fun3_after: ",fun3.__proto__ , typeof(fun3.__proto__))
console.log("fun3_after: ", fun3.prototype, typeof(fun3.prototype))
console.log("obj: ", obj.prototype, typeof(obj.prototype))
console.log("obj: ", obj.__proto__, typeof(obj.__proto__))