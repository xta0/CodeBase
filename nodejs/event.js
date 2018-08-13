var EventEmitter = require ('events')
var util = require ('util')

function MyEmitter(){
	EventEmitter.call(this)
}
util.inherits(MyEmitter, EventEmitter)

MyEmitter.prototype.greet = function(key,data){
	this.emit(key,data)
}
var emitter = new MyEmitter()
emitter.on('Hello', function(data){
	console.log('event triggered! msg: '+data)
})
emitter.greet('Hello','Some_data')
