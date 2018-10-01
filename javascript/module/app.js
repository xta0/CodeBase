var greet1 = require('./module1');
greet1();

var greet2 = require('./module2').greet;
greet2();

var greet3 = require('./module3');
greet3.greet();
greet3.msg = 'Changed greet3';

var greet4 = require('./module3');
greet4.greet();

var util = require('util');
var name = 'Tony';
//看起来像C的print
var greeting = util.format('Hello, %s', name);
util.log(greeting);

const express = require('./module4');
const app = express();
console.log(app.tag);

const x = require('./module5');

console.log('this.children', module.children);
