var express = require('express');
var router = express.Router();
var path = require('path');
var Menu = require(path.resolve(path.dirname(__dirname), "modules/menu"));


/* GET home page. */

router.get('/', function(req, res, next) {
  //This is saying render index.jade(with layout), passing options
  //res.render('index', { title: 'Butts' });
  res.redirect('/index');
});


router.get('/index', function(req, res, next) {
  res.render('index', { menu: Menu.get() });
});

module.exports = router;

//Check for refreshes here, go back to Index, but local storage should for cart
//should be fine
