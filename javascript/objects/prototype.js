/* ProtoType */
function Person(name){
    this.name = name;
} 
console.log(Person.prototype);
console.log(Person.prototype.constructor);

var elie = new Person("elie");
var colt = new  Person("colt");



elie.__proto__ === Person.prototype; // true
colt.__proto__ === Person.prototype; //true 
Person.prototype.constructor === Person; // true

Person.prototype.isInstructor = true;
elie.isInstructor = true;
colt.isInstructor = true;

Person.prototype.sayHi = function (){
    return "Hi "+this.name;
}
var kate = new Person("kate");
kate.sayHi();