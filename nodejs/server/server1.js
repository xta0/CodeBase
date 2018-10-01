const http = require('http');
const hostname = '127.0.0.1';
const port = 3000;

//render text
function sendText(res) {
  res.setHeader('Content-Type', 'text/plain');
  res.write('Hello World\n');
}

//render JSON
function sendJSON(res) {
  res.setHeader('Content-Type', 'application/json');
  var obj = {
    firstname: 'John',
    lastname: 'Doe'
  };
  res.write(JSON.stringify(obj));
}

//render HTML
function sendHTML(res) {
  res.setHeader('Content-Type', 'text/html');
  res.write('<h1>Hello</h1>');
}

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  // sendText(res);
  // sendJSON(res);
  sendHTML(res);
  res.end();
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
