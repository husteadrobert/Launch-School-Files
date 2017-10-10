var App = {
  templates: JST,
  $el: $("main"),
  indexView: function() {
    this.index = new IndexView();
    this.renderAlbums();
    this.createCart();
    this.bindEvents();
  },
  renderAlbums: function() {
    this.albums.each(this.renderAlbumView);
  },
  createCart: function() {
    this.cart = new CartItems();
    this.cart.view = new CartView({
      collection: this.cart
    });
  },
  renderAlbumView: function(album) {
    new AlbumView({
      model: album
    });
  },
  newAlbum: function() {
    //TESTING
    this.newalbumview = new NewAlbumView();
    //new NewAlbumView();
  },
  bindEvents: function() {
    _.extend(this, Backbone.Events);
    this.listenTo(this.index, "add_album", this.newAlbum);
    this.on("add_to_cart", this.cart.addItem.bind(this.cart)); 
  },
};

Handlebars.registerHelper("format_price", function(price) {
  return (+price).toFixed(2);
});

//PROBLEM
//If refresh on new album page, express router picks up submit and spits out the JSON