var express = require('express')
var app = express()
var port = process.env.PORT || 3000

//static file
app.use('/assets',express.static('/public'))

app.get('/',(req,res)=>{
	res.send(
		'<html><head> <link ref="/assets/style.css" type="text/css" rel="stylesheet"/></head><body><h1>HELLO!!</h1></body></html>'
	)
})
app.get('/api',function(req,res){
	res.json({status:'succeed'})
})
//pattern matching
app.get('/person/:id',(req,res)=>{
	res.statusCode = 200
	res.send('<html><head> <link ref=assets/style.css type=text/css rel=stylesheet/></head><body><h1>Person: '+req.params.id + '</h1></body></html>')
})

app.use('/',function(req,res,next){
	console.log('Request Url '+ req.url)
	next()
})



app.listen(port)

