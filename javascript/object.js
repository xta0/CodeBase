
var flight = {
	airline: 'Oceanic',
	departure: {
		IATA: 'CHINA',
		city: 'Hangzhou'
	},
};

var stooge = {
	"first-name": "Jerome",
	"last-name": "Howard",
	"nick": "MotherFuckerHowie"
};

//log property
var logProperties = function (obj) {
	console.log("--properties of " + obj)
	for (var property in obj) {
		console.log(property + "=" + obj[property])
	}
	console.log("----------------------")
}

var prototype = Object.getPrototypeOf(flight);
logProperties(prototype)

console.log(logProperties(stooge));
console.log(logProperties(flight));

console.log(flight.value);
console.log(flight.departure.IATA);
console.log(stooge.nick);
console.log(stooge["middle-name"] || "none")

//Define Property using API
var config = {
	writable: true,
	enumerable: true,
	configurable: true
};
var defineProperty = function (obj, key, value) {
	// config
	config.value = value;
	Object.defineProperty(obj, key, config);
}

var person = Object.create(null);
defineProperty(person, 'first-name', 'peter');
defineProperty(person, 'last-name', 'Zhang');
person["first-name"] // peter
person["last-name"] //Zhang



//Define Property using Prototype
var man = Object.create(null);
defineProperty(man, 'sex', "male");

var yehuda = Object.create(man);
defineProperty(yehuda, 'firstName', "Yehuda");
defineProperty(yehuda, 'lastName', "Katz");

yehuda.sex       // "male"  
yehuda.firstName // "Yehuda"  
yehuda.lastName  // "Katz"

Object.getPrototypeOf(yehuda); // returns the man object  

var person = Object.create(null); //root object
person['fullName'] = function () {
	return this.firstName + ' ' + this.lastName;
}

var man = Object.create(person); //extends person
man['sex'] = "male";

var yehuda = Object.create(man); //concrete object
yehuda.firstName = "Yehuda";
yehuda.lastName = "Katz";

console.log(yehuda.sex);
console.log(yehuda.fullName());