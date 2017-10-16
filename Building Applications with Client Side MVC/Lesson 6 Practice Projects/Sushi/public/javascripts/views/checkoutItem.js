var checkoutItemView = Backbone.View.extend({
  template: App.templates.checkoutItem,
  tagName: "tr",
  events: {
    "click .fa-plus": 'addItem',
    "click .fa-minus": 'subtractItem'
  },
  addItem: function() {
    App.trigger('add_to_cart', this.model);
    this.trigger('itemUpdated');
  },
  subtractItem: function() {
    App.trigger('subtract_from_cart', this.model);
    this.trigger('itemUpdated');
    if (this.model.get('quantity') === 0) {
      this.$el.css('display', 'none');
    }
  },
  render: function() {
    this.$el.attr('data-id', this.model.toJSON().id);
    this.$el.html(this.template(this.model.toJSON()));
    this.$el.appendTo(App.$el.find('tbody'));
  },
  updateCount:function() {
    this.$el.html(this.template(this.model.toJSON()));
  },
  initialize: function() {
    this.render();
    this.on('itemUpdated', this.updateCount);
  },
});