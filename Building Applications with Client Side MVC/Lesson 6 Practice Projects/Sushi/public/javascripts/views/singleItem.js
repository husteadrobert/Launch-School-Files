var singleItemView = Backbone.View.extend({
  template: App.templates.singleItem,
  attributes: {
    "id": "item_details",
  },
  events: {
    "click a.close": "menuView",
    "click a.add_cart": "addToCart",
    "click .prev": "previousItem",
    "click .next": "nextItem",
  },
  previousItem: function() {
    var previousModelIndex = this.model.collection.indexOf(this.model);
    var previousModel = this.model.collection.get(previousModelIndex);
    if (previousModel) {
      this.model = previousModel;
      this.update();
    }
  },
  nextItem: function() {
    var nextModelIndex = this.model.collection.indexOf(this.model) + 2;
    var nextModel = this.model.collection.get(nextModelIndex);
    if (nextModel) {
      this.model = nextModel;
      this.update();
    }
  },
  update: function() {
    this.$el.html(this.template(this.model.toJSON()));
    router.navigate("index/" + this.model.get('id'));
  },
  addToCart: function(e) {
    e.preventDefault();
    App.trigger("add_to_cart", this.model);
  },
  menuView: function(e) {
    e.preventDefault();
    App.trigger("menuView");
  },
  render: function() {
    this.$el.html(this.template(this.model.toJSON()));
  },
  initialize: function() {
    this.render();
  }
});