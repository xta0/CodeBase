var a = 5;
{
    // console.log(a); //error
    let a = 10;
    console.log(a);
}

hide(10);
function hide(arg){
    // let arg=5; //error
    {
        let arg = 5;
        console.log(arg);  // 5
    }
    console.log(arg);      // 10
}

//1、内层变量覆盖了外层变量
var number = 5;
show();
function show(){
    console.log(number);      // undefined
    var number = 10 ;
}
console.log(number)

var a = 1;
// let a = 2; //wrong
var a = 3; //ok

// const a = 4; //wrong
