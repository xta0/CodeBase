// function func(name){
//     console.log(name)
// }

// func.index = 1;
// func.log = function(text){
//     console.log(text)
// }
// func.log("some text")

// console.log(func.__proto__)
// console.log(func.__proto__.__proto__)

function Person(firstname, lastname){
    this.firstname = firstname;
    this.lastname = lastname;
}
Person.prototype.getFullName = function(){
    return this.firstname + " " + this.lastname
}
var john = new Person("John","Doe");
console.log(john.getFullName())

