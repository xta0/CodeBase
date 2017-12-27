

//value(primitives) by copy

var a = 3;
var b;

b = a;
a = 2;

console.log(a);
console.log(b);

//object by reference
var c = { greeting: 'hi' };
var d;

d = c;
d.greeting = 'hello';
console.log(c.greeting);


// parameters by reference
function changeGreeting(obj) {
    obj.greeting = 'Hola';
}

changeGreeting(c);
console.log(c.greeting);

//equals operator sets up new memory space (new address )
c = { greeting: 'howdy' };
console.log(c); //howdy
console.log(d); //Hola


