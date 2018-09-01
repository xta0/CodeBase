var person = {
    firstname: 'Default',
    lastname: 'Default',
    getFullName: function(){
        var fullname = this.firstname + ' ' + this.lastname;
        return fullname;
    }
}
var john = {
    firstname: 'John',
    lastname: 'Doe',
}
//log property
function logProperties(obj) {
	for (var property in obj) {
		console.log(property + " : " + obj[property])
    }
}
function logOwnProperties(obj){
    for(var key in obj){
        if(obj.hasOwnProperty(key)){
            console.log(key+": "+obj[key])
        }
    }
}

//log property of john
//set person as a prototype
john.__proto__ = person
logProperties(john)
console.log("----------------------")
logOwnProperties(john)
console.log("----------------------")
logOwnProperties(john.__proto__)
console.log("----------------------")

