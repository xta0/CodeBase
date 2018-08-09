var greet = require('./module1');
greet();

// var greet = require('./greet')
// greet.english();
// greet.spanish();


// console.log(tao.__proto__ == Person.prototype)

// function Animal(firstname,lastname,age){
//     this.firstname = firstname;
//     this.lastname = lastname;
//     this.age = age;
// }
// console.log(Animal.prototype)
// Animal.prototype = Person.prototype;
// console.log(Animal.prototype)


// var dog = new Animal("Pluto","Xu",3);
// dog.greet();
// console.log(dog.__proto__)

// var object = (function(name){
//     // Keep this variable private inside this closure scope
//   //   var myGrades = [93, 95, 88, 0, 55, 91];
//       var average = function(myGrades) {
//           var total = myGrades.reduce(function(accumulator, item) {
//           return accumulator + item;
//           }, 0);
//           return'Your average grade is ' + total / myGrades.length + '.';
//     };
//       return {
//           name:name,
//           average: average
//       }
//   })();
//   console.log(object.average([93, 95, 88, 0, 55, 91]))