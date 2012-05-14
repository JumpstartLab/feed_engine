$.namespace = {
  activeTabId: null,
  activateTab: (tabId)->
    if $.namespace.activateTabId
      $("##{$.namespace.activateTabId}").removeClass('selected')
    $("##{tabId}").addClass('selected')
    $.namespace.activateTabId = tabId
}

addSubmitHandler = (klass) ->
  $("##{klass}_errors").hide()
  $("##{klass}-submit").click ->
    $("##{klass}_errors").hide()
    form = $("#new_#{klass}")
    formData = form.serialize()
    $.ajax({
      type: "POST",
      url: "/posts",
      data: formData,
      success: ->
        $('#flash').text('Posted successfully')
        form.clearForm()
        $("#feed").children().remove()
        new PostsPager().render()
      error: (response, status)->
        resp = $.parseJSON(response.responseText)
        $("##{klass}_errors").show()
        for error in resp.errors
          $("##{klass}_errors_list").html "<li>#{error}</li>"
    })

addTabMenuHandler = ->
  $('.tab-item').click ->
    $.namespace.activateTab(this['id'])
    tabId = "#{this['id']}-tab".toLowerCase()
    $('.tab-body ul').children().hide()
    $("##{tabId}").show()

addPreviewHandler = ->
  $('#image_url').blur ->
    $('#image_preview').attr('src', $('#image_url').val()).show()

addHandlers = ->
  addSubmitHandler("text")
  addSubmitHandler("image")
  addSubmitHandler("link")
  addPreviewHandler()
  addTabMenuHandler()

jQuery ->
  $('.tab-body ul').children().hide()
  $('.tab-body ul').children().first().show()
  
  addHandlers()
  $.namespace.activateTab('Text')
  if $('#feed').length
    new PostsPager().render()

class PostsPager
  contructor: (@page=0)->
    $(window).scroll(@check)

  check: =>
    if @nearBottom()
      @render

  render: =>
    @page++
    $(window).unbind('scroll', @check)
    $.getJSON($('#feed').data('json-url'), page: @page, @renderPosts)

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50

  renderPosts: (response, status, jqXHR) =>
    posts = response['posts']
    for post in posts
      type = post["type"]
      $("#feed").append Mustache.to_html($("##{type}_template").html(), post)
    $(window).scroll(@check) if posts.length > 0



