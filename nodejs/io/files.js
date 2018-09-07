var fs = require('fs')

var greet = fs.readFileSync(__dirname+'/greet.txt','utf8')
console.log(greet)

var greet2 = fs.readFile(__dirname+'/greet.txt','utf8',(err,data)=>{
	console.log(data)
})

var readable = fs.createReadStream(__dirname+'/20k.txt',{encoding: 'utf8', highWaterMark: 10*1024})

readable.on('data',(chunk)=>{
	console.log(chunk.length)
	writable.write(chunk)
})


//pipe
var writable = fs.createWriteStream(__dirname+'/20k_copy.txt')

readable.pipe(writable)

//create gzip file using pip
var compressed = fs.createWriteStream(__dirname+'/greet.txt.gz')
var zlib = require('zlib')
var gzip = zlib.createGzip()
readable.pipe(gzip).pipe(compressed)