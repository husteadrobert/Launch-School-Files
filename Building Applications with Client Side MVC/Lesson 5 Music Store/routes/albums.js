var path = require("path");
var Albums = require(path.resolve(path.dirname(__dirname), "modules/albums"));
var _ = require("underscore");

module.exports = function(router) {
  router.route("/albums").get(function(req, res) {
    res.json(Albums.get());
  }).post(function(req, res) {
    //req.body is the request
    var album = req.body;
    var albums = Albums.get();

    album.id = Albums.getLastID() + 1;
    albums.push(album);

    Albums.set(albums);
    //res is the response
    res.json(album);
  }).put(function(req, res) {
    var albums = Albums.get();
    var current_album = _(albums).findWhere({id: +req.body.id});

    _.extend(current_album, req.body);
    Albums.set(albums);
    res.json(current_album);
  }).delete(function(req, res) {
    var albums = _(Albums.get()).reject(function(a) {
      return a.id === +req.body.id;
    });
    Albums.set(albums);
    res.status(200).end();
  });

  router.get("/albums/new", function(req, res) {
    res.render("new", {
      albums: Albums.get()
    });
  });
};

