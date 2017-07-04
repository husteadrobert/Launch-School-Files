$(function() {
  $('form').on('submit', function(e) {
    e.preventDefault();
    var itemName = $(this).find('#name').val();
    if (itemName.length === 0) {
      return;
    }
    var quantity = +$(this).find('#quantity').val() || 1; //+ uniary operator to make INt
    var groceryListItem = String(quantity) + ' ' + itemName;
    var $list = $('ul');
    $list.append('<li>' + groceryListItem + '</li>');
    $('form')[0].reset(); //want DOM element here
  });
});