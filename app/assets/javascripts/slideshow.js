$("#slide_show > #slide:gt(0)").hide();

setInterval(function() {
  $('#slideshow > #slide:first')
    .fadeOut(1000)
    .next()
    .fadeIn(1000)
    .end()
    .appendTo('#slideshow');
  },  3000);