var person = {
    firstname: 'John',
    lastname: 'Doe',
    getFullName: function(){
        var fullname = this.firstname + ' ' + this.lastname;
        return fullname;
    }
}

var logName = (function(str1,str2){
    console.log(this.getFullName()) //wrong
}).bind(person)

logName()

function map(arr, fn){
    var ret = []
    for(let item of arr){
        ret.push(fn(item))
    }
    return ret; 
}

const arr = map([1,2,3],function(limit,item){
    return item > 1;
}.bind(this,1))
console.log(arr)

