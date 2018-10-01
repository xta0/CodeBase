var express = require('express');
var router = express.Router();
const request = require('request');
const apiKey = '606546c23a7243bac51b0f12bbe14c87';
const apiBaseUrl = 'http://api.themoviedb.org/3';
const nowPlayingUrl = `${apiBaseUrl}/movie/now_playing?api_key=${apiKey}`;
const imageBaseUrl = 'http://image.tmdb.org/t/p/w300';

router.use((req, res, next) => {
  res.locals.imageBaseUrl = imageBaseUrl;
  next();
});
/* GET home page. */
router.get('/', function(req, res, next) {
  request.get(nowPlayingUrl, (err, _, data) => {
    const jsonData = JSON.parse(data);
    res.render('index', { parsedData: jsonData.results });
  });
});

module.exports = router;
