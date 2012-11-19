jQuery ->
  $('#display_name').autocomplete
    source: $('#display_name').data('autocomplete-source')
  $('.ui-autocomplete').click ->
    $('#search-form').submit()