function func() {
  console.log(arguments[0]); //1
}
func(1, 2, 3);

function listArguments() {
  return arguments;
}

var args = listArguments(1, 2, 3); // type : object
console.log(args); //{ '0': 1, '1': 2, '2': 3 } //seudo array

function sum() {
  let total = 0;
  for (const argument of arguments) {
    total += argument;
  }
  return total;
}

console.log(sum(1, 23, 3, 4));
