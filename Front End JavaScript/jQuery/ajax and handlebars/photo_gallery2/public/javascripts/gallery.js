$(function() {
  var templates = {};
  var photos;
  //var idx = 0;
  var comments = [];
  $('script[type="text/x-handlebars"]').each(function() {
    var $tmpl = $(this);
    templates[$tmpl.attr('id')] = Handlebars.compile($tmpl.html());
  });

  $("[data-type='partial']").each(function() {
    var $partial = $(this);
    Handlebars.registerPartial($partial.attr('id'), $partial.html());
  });
  /*
  $.ajax({
    url: "/photos",
    type: "GET",
    dataType: "json",
  }).done(function(result) {
    var template = $('#photos').html();
    var templateScript = Handlebars.compile(template);
    var html = templateScript({photos: result});
    $('#slides').append(html);

    template = $('#photo_information').html();
    templateScript = Handlebars.compile(template);
    html = templateScript(result[0]);
    $('section > header').append(html);
  });
  */
  $.ajax({
    url: "/photos",
    success: function(json) {
      photos = json;
      renderPhotos();
      renderPhotoInformation(0);
      getCommentsFor(photos[0].id);
    }
  });
/*
  $.ajax({
    url: "/comments?photo_id=" + String(idx),
    success: function(commentsArray) {
      comments = commentsArray;
      Handlebars.registerPartial('comment', $('#comment').html());
      $('#comments > ul').html(templates.comments({comments: comments}));
    }
  });
*/

  $('a.prev').on('click', function(e) {
    e.preventDefault();
    var index = currentPhotoIndex();
    renderCurrentPhoto(index - 1);
  });

  $('a.next').on('click', function(e) {
    e.preventDefault();
    var index = currentPhotoIndex();
    renderCurrentPhoto(index + 1);
  });

  $('section > header').on('click', '.actions a', function(e) {
    e.preventDefault();
    var $element = $(e.target); 

    $.ajax({
      url: $element.attr('href'),
      data: "photo_id=" + $element.attr('data-id'),
      type: "POST",
      success: function(json) {
        $element.text(function(i, txt) {
          return txt.replace(/\d+/, json.total);
        });
      }
    });
  });

  $('form').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
      url: "/comments/new",
      type: "POST",
      data: $(this).serialize(),
      success: function(json) {
        $('#comments ul').append(templates.comment(json));
      }
    });


  });

  function renderCurrentPhoto(index) {
    var totalLength = $('#slides figure').length;
    if (index === totalLength) {
      index = 0;
    } else if (index < 0) {
      index = totalLength - 1;
    }
    $('#slides figure').filter(':visible').fadeOut(500);
    $('#slides figure').eq(index).fadeIn(500);
    $('[name=photo_id').val($('#slides figure').eq(index).attr('data-id'));;
    renderPhotoInformation(index);
    getCommentsFor($('#slides figure').eq(index).attr('data-id'));
  }

  function currentPhotoIndex() {
    return $('#slides figure').filter(':visible').index();
  }

  function renderPhotos() {
    $('#slides').html(templates.photos({photos: photos}));
  }

  function renderPhotoInformation(idx) {
    $("section >header").html(templates.photo_information(photos[idx]));
  }

  function getCommentsFor(idx) {
    $.ajax({
      url: "/comments",
      data: "photo_id=" + idx,
      success: function(comment_json) {
        $('#comments ul').html(templates.comments({ comments: comment_json}));
      }
    });
  }
});