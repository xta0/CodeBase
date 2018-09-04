
// "use strict"
/** Global context **/
// console.log(this); //points to the global object. window

// function whatIsThis() {
// 	// console.log(this); //points to the global object
// 	this.newVariable = 'hello'; //add a new var to this
// }
// whatIsThis();
// console.log(this.newVariable); //hello

/** Object **/
var person = {
	firstName: "Elie",
	sayHi: function () { return "Hi " + this.firstName },
	determineContext: function () {
		return this === person; //true
	},
	dog: {
		sayHello: function(){
			return "Hello "+this.firstName;
		},
		determineContext: function () {
			return this === person;
		}
	}
}
console.log(person.sayHi()); //"Hi Elie"
person.determineContext() //true
person.dog.sayHello(); //"Hello undefined"
person.dog.determineContext(); //false

/* use call, apply, bind */
person.dog.sayHello.call(person); //"Hello Elie"
person.dog.determineContext.call(person); //true 

var colt = {
	firstName: "Colt",
	sayHi: function () { 
		return "Hi " + this.firstName 
	},
	addNumber: function(a,b,c,d){
		return this.firstName + " just calculated "+ (a+b+c+d);
	},
	sayHiLater: function(){
		setTimeout(function(){
			console.log( "Hi Later " + this.firstName );
		}.bind(this),1000)
	}
}

var elie = {
	firstName: "Elie"
}
colt.sayHi(); //Hi Colt
colt.sayHi.call(elie); //Hi Elie
colt.addNumber(1,2,3,4); //'Colt just calculated 10'
colt.addNumber.call(elie,1,2,3,4); //'Elie just calculated 10'
//use apply
colt.addNumber.apply(elie,[1,2,3,4]);//'Elie just calculated 10'
//use bind
var elicAddNumber = colt.addNumber.bind(elie);
elicAddNumber(1,2,3,4);//'Elie just calculated 10'
colt.sayHiLater(); //Hi Later Colt

/* new context */
var Person = function(firstName,lastName){
	this.firstName = firstName //this refers to the Person object
	this.lastName = lastName
}

var tom = new Person("Tom","Xu") 
console.log ( tom.firstName ); 
console.log ( tom.lastName );