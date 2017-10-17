var menuView = Backbone.View.extend({
  template: App.templates.fullMenu,
  tagName: "ul",
  render: function() {
    this.$el.attr('id', 'items');
  },
  initialize: function() {
    this.render();
  }
});