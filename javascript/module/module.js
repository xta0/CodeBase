//1 
(function () {
    console.log("Example 1: Anonymous closure")
}());

//2
(function(globalvars){
    console.log("Example 2: Global import" + globalvars)
})(["1","2",3]);

//3
var object1 = (function(){

    console.log("Example 3: Object interface")
    
    // Keep this variable private inside this closure scope
    // var myGrades = [93, 95, 88, 0, 55, 91];
    
    // Expose these functions via an interface while hiding
    // the implementation of the module within the function() block
    return {
        name:"Kevin",
         age:31,
         tag:function(){
             return "I'm " + this.name + "" + this.age
         }
    }
})();
console.log(object1.tag())



//4
var object2 = (function(){

console.log("Example 4: Revealing module pattern")
 // Keep this variable private inside this closure scope
  var myGrades = [93, 95, 88, 0, 55, 91];

    var average = function() {
        var total = myGrades.reduce(function(accumulator, item) {
        return accumulator + item;
        }, 0);
        return'Your average grade is ' + total / myGrades.length + '.';
  };
  
    
  // Explicitly reveal public pointers to the private functions 
  // that we want to reveal publicly
    return {
        name:"Kevin",
        average: average
    }
})();
console.log(object2.average())

//5 
var myModule = require('./module1');
var myModuleInstance = new myModule();
console.log(myModuleInstance.hello()); // 'hello!'
console.log(myModuleInstance.goodbye()); // 'goodbye!'

//6