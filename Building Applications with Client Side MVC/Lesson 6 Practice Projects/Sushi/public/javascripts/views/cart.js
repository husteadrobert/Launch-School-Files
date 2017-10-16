var cartView = Backbone.View.extend({
  template: App.templates.cart,
  events: {
    "click a.empty_cart": "clearCart",
    "click a.checkout": "checkout",
  },
  clearCart: function(e) {
    e.preventDefault();
    this.$el.slideUp(200, function() {
      this.collection.trigger("clearCart");
    }.bind(this));
  },
  checkout: function(e) {
    e.preventDefault();
    App.trigger("checkoutView");
  },
  updateShoppingCart: function() {
    $('span.count').html(this.collection.getTotalQuantity());
  },
  render: function() {
    this.$el.html(this.template({
      items: this.collection.toJSON(),
      total: this.collection.getTotal()
    }));
    this.updateShoppingCart();
  },
  removeCart: function() {
    this.$el.slideUp(200);
  },
  addCart: function() {
    this.$el.slideDown(200);
  },
  hide: function() {
    this.$el.css('display', 'none');
  },
  unhide: function() {
    if (this.collection.length >= 1) {
      this.$el.css("display", "block");
    }
  },
  initialize: function() {
    this.$el.attr('id', 'cart');
    this.$el.insertBefore($('#content'));
    if (this.collection.length === 0) {
      this.$el.css('display', 'none');
    }
    this.render();
    this.listenTo(this.collection, "cartUpdate", this.render);
    this.listenTo(this.collection, "addCart", this.addCart);
    this.listenTo(this.collection, 'removeCart', this.removeCart);
    this.on('hide', this.hide);
    this.on('unhide', this.unhide);
  }
});