const express = require('express');

const app = express();
app.get('/', (req, res) => {
  res.set({
    'Access-Control-Allow-Origin': 'http://127.0.0.1:5500',
    'Access-Control-Allow-Credentials': 'true',
    'Content-Type': 'application/json'
  });
  res.send('hello');
});
app.listen(9000);
