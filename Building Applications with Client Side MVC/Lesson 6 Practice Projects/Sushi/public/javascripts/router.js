var router = new (Backbone.Router.extend({
  routes: {
    "checkout": App.renderCheckoutView.bind(App),
    "index/:id": "singleItemView",
    "index": App.menuView.bind(App),
    /*
    "/": App.index <--No good, already assumes the /, so would need regular expression.
    */
  },
  menuView: function() {
    App.menuView();
  },
  initialize: function() {
    //Look for slash, that may or may not be there
    //If have, call method on router
    //May not need, because have redirect in express router
    this.route(/^\/?$/, "index", this.menuView)
  }
}))();

router.on("route:singleItemView", function(id) {
  if ( +id > App.menuItems.length || id.match(/[a-z]/i) || +id <= 0) {
    App.menuView();
  } else {
  App.renderSingleItemView(id);
  }
});

//With Router also need History
Backbone.history.start({
  pushState: true
  //Use pushstate so don't actually navigate to pages, but trigger callbacks
});

$(document).on("click", "a[href^='/']", function(e) {
  e.preventDefault();
  router.navigate($(e.currentTarget).attr('href').replace(/^\//, ""), {trigger: true});
//Here, this replaces first / so Backbone router can take it, then optional trigger
//tells Backbone to update the url.  
});