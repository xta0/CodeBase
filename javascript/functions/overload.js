function Person(firstname, lastname){
    this.firstname = firstname;
    this.lastname = lastname;
}

Person.prototype.greet = function(){
     console.log('Hello ' + this.firstname + ' ' + this.lastname);
}
Person.prototype.greet = function(msg){
    console.log(msg);
}

var john = new Person("John","Doe");
john.greet(); //undefined
john.greet("Hello"); 