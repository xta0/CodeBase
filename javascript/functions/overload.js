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

var john = new Person("John","Doe");
john.greet(); //undefined
john.greet("Hello"); 