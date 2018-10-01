const path = require('path');
const express = require('express');
const app = express();

//middleware
app.use(express.static('public'));

//create req.body
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.post('/ajax', (req, res) => {
  //console.log(req.headers); //get header content
  //set header content
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.json('JSON');
});

//server side rendering:
//1, define a view engine
// - HTML (default)
// - EJS
// - Mustache
// - Handlebars
// - Jade/Pug
//2. Inside route, use res.render(file, data)

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.get('/', (req, res) => {
  res.render('index', { msg: 'success!' });
});

app.listen(3000);
