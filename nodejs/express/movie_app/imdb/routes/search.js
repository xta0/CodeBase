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
router.post('/', function(req, res) {
  const searchTerm = encodeURI(req.body.movieSearch);
  const cat = req.body.cat;
  const url = `${apiBaseUrl}/search/${cat}?query=${searchTerm}&api_key=${apiKey}`;
  request.get(url, (err, _, data) => {
    let jsonData = JSON.parse(data);
    if (cat === 'person') {
      jsonData.results = jsonData.results[0].known_for;
    }
    res.render('index', { parsedData: jsonData.results });
  });
});

module.exports = router;
