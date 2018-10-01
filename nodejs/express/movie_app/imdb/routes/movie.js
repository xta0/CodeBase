var express = require('express');
var router = express.Router();
const request = require('request');
const apiKey = '606546c23a7243bac51b0f12bbe14c87';
const apiBaseUrl = 'http://api.themoviedb.org/3';
const imageBaseUrl = 'http://image.tmdb.org/t/p/w300';

router.use((req, res, next) => {
  res.locals.imageBaseUrl = imageBaseUrl;
  next();
});
/* GET home page. */
router.get('/:id', function(req, res) {
  const id = req.params.id;
  const url = `${apiBaseUrl}/movie/${id}?api_key=${apiKey}`;
  request.get(url, (err, _, data) => {
    const jsonData = JSON.parse(data);
    // res.json(jsonData);
    res.render('movie', { parsedData: jsonData });
  });
});

module.exports = router;
