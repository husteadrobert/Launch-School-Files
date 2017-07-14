$(function () {
  var $canvas = $('#canvas');

  function getFormInfo($f) {
    var o = {};

    $f.serializeArray().forEach(function(input) {
      o[input.name] = input.value;
    });
    return o;
  }
  function createElement(data) {
    var $d = $('<div />', {
        "class": data.shapeType,
        "data-endY": data.endY,
        "data-endX": data.endX,
        css: {
          left: +data.startX,
          top: +data.startY,
        }
      });
    return $d
  }

  $('form').on('submit', function(e) {
    e.preventDefault();

    var $form = $(this);
    var dataObject = getFormInfo($form);

    var $element = createElement(dataObject);

    $canvas.append($element);

  });

  $('p a').on('click', function(e) {
    $canvas.find('div').each(function() {
      var $div = $(this);
      console.log($div);
    })
  });

});