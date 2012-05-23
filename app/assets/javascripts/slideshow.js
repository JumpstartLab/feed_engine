jQuery("#slide_show > #slide:gt(0)").hide();

setInterval(function() {
  jQuery('#slide_show > #slide:first')
    .fadeOut(1000)
    .next()
    .fadeIn(1000)
    .end()
    .appendTo('#slide_show');
},  4000);