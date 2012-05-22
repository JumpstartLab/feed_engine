jQuery ->
  $('#display_name').autocomplete
    source: $('#display_name').data('autocomplete-source')
  $('.ui-corner-all').click ->
    $('#search-form').submit()