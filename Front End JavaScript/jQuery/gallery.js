$(function() {
  var $slideshow = $('#slideshow'),
      $nav = $slideshow.find('ul');

  $nav.on('click', 'a', function(e) { //This is event Delegation.
    e.preventDefault();
    var $li = $(e.currentTarget).closest('li'); //Going from Anchor to closest li
    var idx = $li.index();

    $slideshow.find('figure').stop().filter(':visible').fadeOut(300);
    $slideshow.find('figure').eq(idx).delay(300).fadeIn(300);
    //Find all figures, filter, hide it, go back to previous all figure context,
    //get element at idx, and show it.
    //$slideshow.find('figure').filter(':visible').hide().end().eq(idx).show()
    $nav.find('.active').removeClass('active');
    $li.addClass('active');
  });
});