jQuery ->
  $('.unsubscribe_button').click ->
    $('.unsubscribe_button').parent("div").parent().parent().parent().fadeOut()
