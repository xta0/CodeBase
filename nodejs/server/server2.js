var http = require('http');
var fs = require('fs');

const server = http.createServer(function(req, res) {
  res.writeHead(200, { 'Content-Type': 'text/html' });
  const indexHTML = fs.readFileSync(__dirname + '/public/index.html');
  res.write(indexHTML);
  res.end();
});
server.listen(1337, '127.0.0.1');
