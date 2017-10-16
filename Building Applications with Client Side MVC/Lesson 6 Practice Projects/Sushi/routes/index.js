var express = require('express');
var router = express.Router();
var path = require('path');
var Menu = require(path.resolve(path.dirname(__dirname), "modules/menu"));


/* GET home page. */

router.get('/', function(req, res, next) {
  res.redirect('/index');
});


router.get('/index', function(req, res, next) {
  res.render('index', { menu: Menu.get() });
});

router.get('/checkout', function(req, res, next) {
  res.render('index', { menu: Menu.get() });
});

router.get('/index/:id', function(req, res, next) {
  res.render('index', { menu: Menu.get() });
});

module.exports = router;