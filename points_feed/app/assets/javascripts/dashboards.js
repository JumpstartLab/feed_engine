$(document).ready(function() {
  $('#post_tabs a').bind('click', function(e) {
    $(".form-error").hide();
    
    var parts = decodeURI(e.target).split('#');
    $.cookie('cur_tab', parts['1']);
  });

  $('#nav_tabs a').bind('click', function(e) {
    var parts = decodeURI(e.target).split('#');
    $.cookie('nav_tabs_tab', parts['1']);
  });

  if($.cookie('cur_tab') == null) {
    $.cookie('cur_tab', 'text_post');
  }

  if($.cookie('nav_tabs_tab') == null) {
    $.cookie('nav_tabs_tab', 'posts_tab');
  }

  $('#post_tabs a[href="#'+$.cookie('cur_tab')+'"]').tab('show');
  $('#nav_tabs a[href="#'+$.cookie('nav_tabs_tab')+'"]').tab('show');
});