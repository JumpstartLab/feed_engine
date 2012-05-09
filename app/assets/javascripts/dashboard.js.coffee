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

  addSubmitHandler = (klass) ->
    $("##{klass}-submit").click ->
      form = $("#new_#{klass}")
      formData = form.serialize()
      $.ajax({
        type: "POST",
        url: "/posts",
        data: formData,
        success: ->
          $('#flash').text('Posted successfully')
          form.clearForm()
        error: (response, status)->
          resp = $.parseJSON(response.responseText)
          $('#errors').html Mustache.to_html($('#errors_list_template').html())
          for error in resp.errors
            $('#errors_list').html "<li>#{error}</li>"
        })


  addSubmitHandler("text")
  addSubmitHandler("image")
  addSubmitHandler("link")

