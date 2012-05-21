$(document).ready(function(){
  $('.text-message')
    .after("<span></span>")
    .next()
    .hide()
    .end()
    .keypress(function(e) {
      var current = $(this).val().length;
      if(current >= 512) {
        if(e.which != 0 && e.which != 8) {
          e.preventDefault();
        }
      }
      $(this).next().show().text(512 - current);
    });
});

