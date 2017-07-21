var initialSettings = {
  currentTab: 0,
  bgColor: 'red',
  message: 'Initial Settings',
};

function getSettings() {
  return JSON.parse(localStorage.getItem('settings'));
}

var settings = getSettings() || initialSettings;

$(function() {
  init();

  $('nav').on('click', 'a', function(e) {
    e.preventDefault();
    $element = $(this);
    $element.closest('nav').find('.active').removeClass('active');
    $element.addClass('active');

    var idx = $element.closest('li').index();
    $('article').hide().eq(idx).show();
    settings.currentTab = idx;
  });

  $(':radio').on('change', function() {
    var color = $(this).val();
    $('body').css('background-color', color);
    settings.bgColor = color;
  });

  $(window).on('unload', function(e) {
    settings.message = $('textarea').val();
    localStorage.setItem('settings', JSON.stringify(settings));
  });
});

function init() {
  $('article').hide().eq(settings.currentTab).show();
  $('nav li').eq(settings.currentTab).find('a').addClass('active');
  $('body').css('background-color', settings.bgColor);
  $('[value=' + settings.bgColor +']').prop('checked', true).change();
  $('textarea').val(settings.message);
}