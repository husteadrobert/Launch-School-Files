var itemView = Backbone.View.extend({
  template: App.templates.menuItem,
  tagName: "li",
  render: function() {
    var id = this.model.get('id');
    this.$el.attr('data-id', id);
    this.$el.html(this.template(this.model.toJSON()));
    this.$el.appendTo(App.$el.find('ul'));
  },
  initialize: function() {
    this.render();
    this.model.view = this;
  }
})