moveScroller = ->
  offset = $(window).scrollTop()
  anchor = $("#anchor").offset().top
  minidash = $("#minidash")

  if (offset > anchor)
    minidash.css({position:"fixed",top:"0px"})
  else if (offset <= anchor)
    minidash.css({position:"fixed",top:""})

$(->
  # Hook into the scroll event,
  # and go ahead and scroll.
  $(window).scroll(moveScroller)
  moveScroller())