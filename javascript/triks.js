function listArguments(){
	return arguments;
}

var args = listArguments(1,2,3);// type : object 
console.log (args); //{ '0': 1, '1': 2, '2': 3 }

