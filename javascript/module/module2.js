function Person(firstname, lastname){
    this.firstname = firstname;
    this.lastname = lastname;
    this.greet = function(msg){
        console.log(msg);
    }
}
Person.prototype.greet = function(){
    console.log('Hello ' + this.firstname + ' ' + this.lastname);
}
module.exports = Person;