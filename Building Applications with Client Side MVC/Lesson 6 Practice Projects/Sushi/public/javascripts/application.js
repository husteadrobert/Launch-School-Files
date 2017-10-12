var App = {
  templates: JST,
  $el: $('#content'),
  menuView: function() {
    this.menuView = new menuView();
    this.renderMenuItems();
  },
  renderMenuItems: function() {
    this.menuItems.each(this.renderItemView);
  },
  renderItemView: function(item) {
    new itemView({
      model: item
    });
  }
};