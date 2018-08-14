var util = require('./util')
var Person = require('./Person')

util.inheritate(Policemen, Person);
function Policemen(firstname, lastname, number) {
    Person.apply(this, [firstname, lastname])
    this.number = number;
}

// Policemen.prototype = new Person()
var policemen = new Policemen("John", "Doe", 1234)
console.log(policemen.number)
console.log(policemen.firstname)
console.log(policemen.lastname)
console.log(policemen.greet())
