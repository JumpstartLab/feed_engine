$(function() {
  $(window).scroll(function() {
    if($(this).scrollTop() != 0) {
      $('#totop').fadeIn(); 
    } else {
      $('#totop').fadeOut();
    }
  });
 
  $('#totop').click(function() {
    $('body,html').animate({scrollTop:0},600);
  }); 
});