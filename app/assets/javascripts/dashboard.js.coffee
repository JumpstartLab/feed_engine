# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.tab-body ul').children().hide()
  $('.tab-body ul').children().first().show()
  $('.tab-item').click ->
    tabId = "#{this['id']}-tab".toLowerCase()
    $('.tab-body ul').children().hide()
    $("##{tabId}").show()


  $('#text-submit').click ->
    form = $('#new_text')
    formData = form.serialize()
    $.ajax({
      type: "POST",
      url: "/posts",
      data: formData,
      success: ->
        $('#flash').text('Posted successfully')
        form.clearForm()
      error: (response, status)->
        $('#flash'). "#{response.responseText}"
      })
