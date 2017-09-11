var ListView = Backbone.View.extend({
  el: '#favorites',
  render: function() {
    this.collection.each(this.renderOne.bind(this));
  },
  renderOne: function(model) {
    var listItemView = new ListItemView({model: model});
    this.$el.append(listItemView.render());
  },
  initialize: function() {
    this.listenTo(this.collection, 'add', this.renderOne);
  },
});