

console.log('hello world!');

const f1 = function () {
	console.log('hello f1');
};

f1();
f1.name = 'f1';
console.log(f1);
console.log(f1.name);

function f2() {
	console.log('hello f2');
}
f2();
f2.name = 'f2';
console.log(f2);
console.log(f2.name);


const obj = {
	name: 'Jayson'
};

function mutate(p) {
	p.name = 'Kate';
}
mutate(obj);
console.log(obj);
