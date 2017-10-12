var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var stylus = require('stylus');
var nib = require('nib');

var app = express();

// view engine setup, Use this for Layout and Jade
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
//For mixins with jade, so just require / _mixins
app.locals.basedir = path.join(__dirname, 'views');

app.use(stylus.middleware({
  src: path.join(__dirname, "public"),
  compile: function(str, p) {
    return stylus(str).set("filename", p).use(nib());
  }
}));

app.use(favicon(path.join(__dirname, 'public/images', 'sushiicon.png')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

//Routing
//Use just one route, index, and in that file load information for menu
//var routes = require('./routes/index'); <---Get the route file
//app.use('/', routes); <---Use the route file
var routes = require('./routes/index');
app.use('/', routes);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
