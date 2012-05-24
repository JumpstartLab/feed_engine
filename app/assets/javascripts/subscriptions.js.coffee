jQuery ->
  $('.unsubscribe_button').click ->
    $('.unsubscribe_button').parent("div").parent().fadeOut()
