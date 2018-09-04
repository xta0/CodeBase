var add = function (a,b){
    if(typeof a != 'number' || typeof b != 'number'){
        throw{
            name: 'TypeError',
            message: 'add needs numbers'
        };
    }
    console.log("add run");
    return (a+b);
}

var  try_it = function(x,y){
    try{
        console.log(add(x,y));
    }catch(e){
        console.log(e.name, e.message)
    }
}

try_it(1,"10");
