var itemView = Backbone.View.extend({
  template: App.templates.menuItem,
  tagName: "li",
  events: {
    "click footer a": "addToCart",
    "click header": "displaySingleItem"
  },
  displaySingleItem: function(e) {
    e.preventDefault();
    App.trigger("displaySingleItem", this.model.get('id'));
  },
  addToCart: function(e) {
    e.preventDefault();
    App.trigger("add_to_cart", this.model)
  },
  render: function() {
    var id = this.model.get('id');
    this.$el.attr('data-id', id);
    this.$el.html(this.template(this.model.toJSON()));
  },
  initialize: function() {
    this.render();
    this.model.view = this;
  }
});