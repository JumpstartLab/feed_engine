jQuery ->
  $('.unsubscribe_button').click ->
    $(this).parent("div").parent().parent().parent().fadeOut()