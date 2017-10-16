var cartItems = Backbone.Collection.extend({
  addItem: function(item) {
    if (this.length === 0) {
      this.trigger("addCart");
    }
    var existing = this.get(item.get('id'));
    if(existing) {
      existing.set('quantity', existing.get('quantity') + 1);
    } else {
      existing = item.clone();
      existing.set('quantity', 1);
      this.add(existing);
    }
    this.update();
  },
  subtractItem: function(item) {
    var currentItem = this.get(item.get('id'));
    currentItem.set('quantity', currentItem.get('quantity') - 1);
    if (currentItem.get('quantity') === 0) {
      this.removeItem(item);
    }
    this.update();
  },
  removeItem: function(item) {
    this.remove(item);
  },
  readStorage: function() {
    var storedCart = JSON.parse(localStorage.getItem('cart'));
    this.reset(storedCart);
    this.setTotal().setTotalQuantity();
  },
  updateStorage: function() {
    localStorage.setItem('cart', JSON.stringify(this.toJSON()));
  },
  clearCart: function() {
    this.reset();
    this.update();
  },
  setTotal: function() {
    this.total = this.toJSON().reduce(function(a, b) {
      return a + b.price * b.quantity;
    }, 0);
    return this;
  },
  setTotalQuantity: function() {
    this.totalQuantity = this.toJSON().reduce(function(a, b) {
      return a + b.quantity;
    }, 0);
    return this;
  },
  getTotal: function() { return this.total },
  getTotalQuantity: function() { return this.totalQuantity },
  update: function() {
    this.setTotal().setTotalQuantity().updateStorage();
    this.trigger("cartUpdate");
  },
  initialize: function() {
    this.readStorage();
    this.on('clearCart', this.clearCart);
  }
});