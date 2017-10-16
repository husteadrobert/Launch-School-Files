var checkoutView = Backbone.View.extend({
  //cartTotal: $('#cart .total').html(),
  template: App.templates.checkout,
  events: {
    "click footer a": "order",
    "submit": "order"
  },
  order: function(e) {
    e.preventDefault();
    this.collection.trigger("clearCart");
    this.collection.trigger("removeCart");
    App.trigger("menuView");
  },
  render: function() {
    var cartTotal = $('#cart .total').html();
    this.$el.attr('id', 'checkout');
    this.$el.html(this.template({total: cartTotal}));
    App.$el.html(this.$el);
  },
  updateTotalPrice: function() {
    this.totalPrice = this.collection.getTotal();
    this.$el.find('.total').html($('#cart .total').html());
  },
  initialize: function() {
    this.render();
    this.listenTo(this.collection, "cartUpdate", this.updateTotalPrice);
  }
})