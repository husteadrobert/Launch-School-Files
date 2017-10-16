var menuView = Backbone.View.extend({
  template: App.templates.fullMenu,
  tagName: "ul",
  render: function() {
    this.$el.attr('id', 'items');
    App.$el.html(this.$el);
  },
  initialize: function() {
    this.render();
  }
});