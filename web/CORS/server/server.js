const path = require('path');
const fs = require('fs');
const express = require('express');
const app = express();
const cookieParser = require('cookie-parser');
const helmet = require('helmet');

//setup view engines
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

//middleware
app.use(express.static('public'));
//create req.body
app.use(helmet());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use((req, res, next) => {
  //get query string
  if (req.query.msg === 'fail') {
    res.locals.msg = 'Sorry Wrong Password!';
  } else {
    res.locals.msg = '';
  }
  next();
});

app.get('/', (req, res) => {
  res.json('success');
});

app.get('/login', (req, res) => {
  res.render('login');
});
app.post('/process_login', (req, res) => {
  //save user name in cookie
  // send them to welcome page

  const username = req.body.username;
  const password = req.body.password;
  if (password === 'x') {
    res.cookie('username', username);
    //res.redirect takes 1 arg
    res.redirect('/welcome');
  } else {
    res.redirect('/login?msg=fail');
  }
});

app.post('/transaction', (req, res) => {
  console.log(req.body);
  console.log('cookie: ', req.cookies);
  const url = path.join(__dirname + '/Files/trans.json');
  const rawdata = fs.readFileSync(url, 'utf-8');
  let jsondata = JSON.parse(rawdata);
  const trans = [...jsondata, { name: req.body.name, amount: req.body.amount }];
  const data = JSON.stringify(trans);
  fs.writeFileSync(url, data);
  res.redirect('/welcome');
});

app.get('/welcome', (req, res) => {
  //fetch data from file
  const rawdata = fs.readFileSync(
    path.join(__dirname + '/Files/trans.json'),
    'utf-8'
  );
  const trans = JSON.parse(rawdata);
  res.render('welcome', { username: req.cookies.username, trans });
});

app.get('/logout', (req, res) => {
  res.clearCookie('username');
  res.redirect('/login');
});
app.listen(5000);
