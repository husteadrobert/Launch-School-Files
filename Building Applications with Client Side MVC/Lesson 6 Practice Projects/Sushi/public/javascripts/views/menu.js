var menuView = Backbone.View.extend({
  template: App.templates.fullMenu,
  tagName: "ul",
  render: function() {
    this.$el.attr('id', 'items');
    this.$el.appendTo(App.$el);
  },
  initialize: function() {
    this.render();
  }
});