var canvas = document.createElement("canvas");
var ctx = canvas.getContext('2d');

var manipulator = {
  init: function(picture) {
    console.log('init function');
    canvas.width = picture.width;
    canvas.height = picture.height;
    ctx.drawImage(picture, 0, 0);
    var imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    this.convert(imageData);
  },
  convert: function(imageData) {
    for (var i = 0; i < imageData.data.length; i += 4) {
      var gray = (imageData.data[i] * .3086) + (imageData.data[i+1] * .6094) + (imageData.data[i+2] * .0820);
      imageData.data[i] = gray;
      imageData.data[i+1] = gray;
      imageData.data[i+2] = gray;
    }
    ctx.putImageData(imageData, 0, 0);
  },
  newURL: function() {
    return canvas.toDataURL('png');
  },
};

$(window).on('load', function() {
  var $pictures = $('img');
  var newPic;
  var URL;
  $pictures.each(function() {
    manipulator.init(this);
    newPic = document.createElement('img');
    URL = manipulator.newURL();
    $(newPic).attr('src', URL);
    $('#after').append(newPic);
  });
});