function func() {
    console.log(arguments[0]) //1
}
func(1, 2, 3)

function sum() {
    let total = 0;
    for (const argument of arguments) {
        total += argument;
    }
    return total;
}

console.log(sum(1, 23, 3, 4))