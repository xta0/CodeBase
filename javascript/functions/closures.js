// Example #1
function outer() {
  var data = 'closures are ';
  return function inner() {
    //this function capture the outside variable "data"
    var innerData = 'awesome';
    return data + innerData;
  };
}
console.log(outer()()); //closures are awesome

// Example #2
/* hide private variable */
function counter() {
  var count = 0;
  return function() {
    return ++count;
  };
}
var countFn = counter();
console.log(countFn());
console.log(countFn());

//Example #3
function classRoom() {
  var instructors = ['Colt', 'Elie'];
  return {
    getInstructors: function() {
      return instructors;
    },
    addInstructor: function(instructor) {
      instructors.push(instructor);
      return instructors;
    }
  };
}

var course1 = classRoom();
course1.getInstructors(); //['Colt', 'Elie']
course1.addInstructor('Ian'); //[ 'Colt', 'Elie', 'Ian' ]
