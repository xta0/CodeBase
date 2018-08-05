
hello();
console.log(a);

var a = 30;
function hello(){
	console.log("hello!");
}

function func_1(){
	return func_2();
}

console.log(func_1());

function func_2(){
	return "this is func_2";
}