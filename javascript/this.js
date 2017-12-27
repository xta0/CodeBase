

console.log(this); //points to the global object

function a() {
	console.log(this); //points to the global object
	this.newVariable = 'hello';
}

const b = function () {
	console.log(this); ///points to the global object
};

const c = {

	name: 'The c object',
	log: function () {
		console.log(this);
	}
};

console.log(this.newVariable);

a();
console.log(newVariable);
b();
c();
const addListener = function (eventType, listener) {
	console.log(eventType);
	console.log(listener);

	listener();
};

const object = {
	value: 0,
	// IncrementValue: (v) => {
	// 	this.value = this.value + v;
	// 	console.log(this.value);
	// },
	IncrementValue: (v) => {
		this.value = this.value + v;
		console.log(this.value);
	},

	IncrementValue1: (v) => {
		const that = this;
		const func = (_v) => {
			that.value += _v;
		};
		func(v);
	},
	IncrementValue2: (v) => {
		const func = function (_v) {
			this.value += _v;
		}.bind(this);
		func(v);
	}
};

object.IncrementValue(10);
//object.IncrementValue1(10);
//object.IncrementValue2(10);
console.log(object.value);

addListener('jayson', () => { console.log('hahah'); });
