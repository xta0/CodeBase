var buf = new Buffer('Hello','utf8')
console.log(buf)
console.log(buf.toString())
console.log(buf.toJSON())

var buffer = new ArrayBuffer(8) //创建一个8x8=64bit的缓存
var view = new Int32Array(buffer) //创建一个TypedArray，每个元素长度为32bit
view[0] = 10
view[1] = 20
console.log(view)