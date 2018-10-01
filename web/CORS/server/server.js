const path = require('path');
const express = require('express');
const app = express();
const cookieParser = require('cookie-parser');

//setup view engines
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

//middleware
app.use(express.static('public'));
//create req.body
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
app.get('/welcome', (req, res) => {
  res.render('welcome', { username: req.cookies.username });
});

app.get('/statement', (req, res, next) => {
  //res has a download method, takes 2 args:
  //1. filename
  //2. optionally, what you want the filename to download as

  //download is setting the headers!
  //1. content-dispostion to attachment, with a filename of the 2nd arg
  res.download(path.join(__dirname, 'pics/node.png'), 'download.png', err => {
    //if there is an error in sending file, headers may already be sent
    if (err) {
      //res.headerSent is a bool, true if headers are already sent
      if (!res.headersSent) {
        res.redirect('/download/error');
      }
    }
  });

  //this will render image in browser
  // res.sendFile(path.join(__dirname, 'pics/node.png'))
});

app.get('/logout', (req, res) => {
  res.clearCookie('username');
  res.redirect('/login');
});
app.listen(5000);
