var util = require('./util')
var Person = require('./Person')

util.inheritate(Policemen, Person);
function Policemen(options){ //需要传入”父类“需要的参数
    //调用"父类"构造函数
    console.log(options)
    Person.call(this,options)
    this.number = options.number;
}

var policemen = new Policemen({firstname: "John", lastname:"Doe", number:1234})
// var policemen = new Policemen("John", "Doe", 1234)
console.log(policemen.number)
console.log(policemen.firstname)
console.log(policemen.lastname)
console.log(policemen.greet())
