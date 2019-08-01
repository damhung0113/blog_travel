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
