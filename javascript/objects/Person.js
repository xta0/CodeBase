function Person(options){
    this.firstname = options.firstname;
    this.lastname = options.lastname;
    this.func = function(){
        console.log("person")
    }
}
Person.prototype.greet = function(){
    return "Hello "  + this.firstname + ' ' + this.lastname;
}
module.exports = Person;