var obj = {
	greet: 'hello'
}

obj['greet'] = 'greet'
console.log(obj.greet)

var arr = []

arr.push(function(){
	console.log('Hello World!')
})
