const path = require('path');
const express = require('express');
const app = express();
var bodyParser = require('body-parser');

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'html');
app.get('/', (req, res) => {
  res.render('index', { title: 'Bank' });
});
app.post('/submit', (req, res) => {
  res.json(req.body);
});
app.post('/login', (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  res.setHeader('Set-Cookie', 'a');
});
app.listen(9000);
