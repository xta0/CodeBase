function isEven(num) {
    return num % 2 === 0;
}
isEven(3);

function factorial(num) {

    if (num < 0) {
        console.log("Negtive Number");
        return -1;
    }
    else if (num === 0) {
        return 1;
    }
    else {
        return num * factorial(num - 1);
    }
}
factorial(19);