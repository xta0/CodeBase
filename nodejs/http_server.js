var http = require('http')
var fs = require('fs')

// http.createServer(function(req,res){
// 	res.writeHead(200,{'Content-Type':'text/plain'})
// 	fs.createReadStream(__dirname+'/20k.txt').pipe(res)
// 	// res.end('Hello world\n')
// }).listen(1337,'127.0.0.1')


http.createServer(function(req,res){
	res.writeHead(200,{'Content-Type':'application/json'})
	var obj = {
		firstname:'John',
		lastname:'Doe'
	}
	res.end(JSON.stringify(obj))
	
}).listen(1337,'127.0.0.1')