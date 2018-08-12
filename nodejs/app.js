var Emitter = require('events')
var emtr = new Emitter()
emtr.on('greet',function(){
	console.log('#1 said hello.')
})
emtr.on('greet',function(){
	console.log('#2 said hello.')
})

emtr.emit('greet')

