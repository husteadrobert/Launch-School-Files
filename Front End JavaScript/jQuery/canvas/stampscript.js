$(function() {
  var method = 'none';
  var canvas = $('canvas')[0];
  var ctx = canvas.getContext('2d');

  $('ul').on('click', 'a', function(e) {
    e.preventDefault();
    $element = $(this);
    if ($element.attr('data-method') === 'clear') {
      drawingMethods.clear();
      return;
    }
    $element.closest('ul').find('.active').removeClass('active');
    $element.addClass('active');
    method = $element.attr('data-method');
  });

  $('canvas').on('click', function(e) {
    color = $('input').val() || 'black'
    drawingMethods[method](e);
  })

  var drawingMethods = {
    circle: function(e) {
      ctx.fillStyle = color;
      ctx.beginPath();
      ctx.arc(e.offsetX, e.offsetY, 10, 0, 2 * Math.PI);
      ctx.stroke();
      ctx.fill();
      ctx.closePath();
    },
    square: function(e) {
      ctx.fillStyle = color;
      ctx.fillRect(e.offsetX - 10, e.offsetY - 10, 20, 20);
    },
    triangle: function(e) {
      ctx.fillStyle = color;
      var x = e.offsetX;
      var y = e.offsetY;
      ctx.beginPath();
      ctx.moveTo(x, y-10);
      ctx.lineTo(x + 20, y + 10);
      ctx.lineTo(x - 20, y + 10);
      ctx.lineTo(x, y-10);
      ctx.stroke();
      ctx.fill();
      ctx.closePath();
    },
    clear: function() {
      var previousColor = color;
      ctx.fillStyle = 'white';
      ctx.fillRect(0, 0, canvas.width, canvas.height);
      ctx.fillStyle = previousColor;
    },
    none: function() {
      return;
    }
  };
});