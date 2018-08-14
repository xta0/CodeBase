function Person(firstname, lastname){
    this.firstname = firstname;
    this.lastname = lastname;
}
Person.prototype.greet = function(){
    return "Hello "  + this.firstname + ' ' + this.lastname;
}
module.exports = Person;