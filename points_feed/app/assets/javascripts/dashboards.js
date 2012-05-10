$(document).ready(function() {
  $('#post_tabs a').bind('click', function(e) {
    $(".form-error").hide();
    
    var parts = decodeURI(e.target).split('#');
    $.cookie('cur_tab', parts['1']);
  });

  if($.cookie('cur_tab') === undefined) {
    $.cookie('cur_tab', 'text_post');
  }

  $('#post_tabs a[href="#'+$.cookie('cur_tab')+'"]').tab('show');
});