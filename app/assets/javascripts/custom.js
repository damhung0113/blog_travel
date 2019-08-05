$(document).ready(function() {
  $(window).scroll(function(){
    var windowTop = $(window).scrollTop();

    if (windowTop > 200) {
      $('#mainNav').addClass("navbar-shrink");
    } else {
      $('#mainNav').removeClass("navbar-shrink");
    }
  });
});

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#img_prev')
        .attr('src', e.target.result)
        .width(370)
        .height(200);
    }
    reader.readAsDataURL(input.files[0]);
  }
}

$(document).on('turbolinks:load', function(){
  $("#cover_photo_upload").change(function(){
    readURL(this);
  });
  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      CKEDITOR.replace(data[i].id);
    });
  }
});
