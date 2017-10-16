var App = {
  templates: JST,
  eventsBound: false,
  $el: $('#content'),
  menuView: function() {
    if (!this.cart) { this.createCart(); }
    if (!this.eventsBound) { this.bindEvents(); }
    this.cart.view.trigger('unhide');
    this.menu = new menuView();
    this.renderMenuItems();
    router.navigate("index");
  },
  createCart: function() {
    this.cart = new cartItems();
    this.cart.view = new cartView({
      collection: this.cart
    });
  },
  renderMenuItems: function() {
    this.menuItems.each(this.renderItemView);
  },
  renderItemView: function(item) {
    new itemView({
      model: item
    });
  },
  renderCheckoutView: function() {
    if (!this.cart) { this.createCart(); }
    if (!this.eventsBound) { this.bindEvents(); }
    new checkoutView({
      collection: this.cart
    });
    this.cart.view.trigger('hide');
    this.cart.each(this.renderCheckoutItem);
    router.navigate("checkout");
  },
  renderCheckoutItem: function(item) {
    new checkoutItemView({
      model: item
    });
  },
  renderSingleItemView: function(id) {
    if (!this.cart) { this.createCart(); }
    if (!this.eventsBound) { this.bindEvents(); }
    this.cart.view.trigger('unhide');
    var currentItem = this.menuItems.get(id);
    new singleItemView({
      model: currentItem
    });
    router.navigate("index/" + id);
  },
  bindEvents: function() {
    _.extend(this, Backbone.Events);
    this.on("add_to_cart", this.cart.addItem.bind(this.cart));
    this.on("subtract_from_cart", this.cart.subtractItem.bind(this.cart));
    this.on("checkoutView", this.renderCheckoutView.bind(this));
    this.on("menuView", this.menuView.bind(this));
    this.on("displaySingleItem", this.renderSingleItemView.bind(this));
    $('header a').on("click", function(e) {
      e.preventDefault();
      this.menuView();
    }.bind(this));
    this.eventsBound = true;
  },
};

Handlebars.registerHelper('formatPrice', function(price) {
  return (+price).toFixed(2);
});

Handlebars.registerHelper('subtotal', function(price, quantity) {
  return (+price * +quantity).toFixed(2);
})