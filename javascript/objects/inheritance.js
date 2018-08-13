

var util = require('./util')

function Parent(relation){

}
function Person(firstname, lastname){
    this.firstname = firstname;
    this.lastname = lastname;
}
Person.prototype.greet = function(){
    return "Hello "  + this.firstname + ' ' + this.lastname;
}

function Policemen(firstname,lastname,number){
    Person.apply(this,[firstname,lastname])
    this.number = number;
}
util.inheritate(Policemen,Person);
// Policemen.prototype = new Person()
var policemen = new Policemen("John","Doe",1234)
console.log(policemen.number)
console.log(policemen.firstname)
console.log(policemen.lastname)
console.log(policemen.greet())
