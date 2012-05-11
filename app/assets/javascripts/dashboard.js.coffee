# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.namespace = {
  activeTabId: null,
  activateTab: (tabId)->
    if $.namespace.activateTabId
      $("##{$.namespace.activateTabId}").removeClass('selected')
    $("##{tabId}").addClass('selected')
    $.namespace.activateTabId = tabId
  }

update = ->
  $.ajax({
    type: "GET",
    url: "/posts",
    data: { page: window.page_count }
    success: (response, status, jqXHR)->
      posts = response["posts"]
      for post in posts
        render(post)
        })

render = (post) ->
  type = post["type"]
  feed = $("#feed")

  if type == "text"
    feed.append(text_to_html(post)).show()
  else if type == "image"
    feed.append(image_to_html(post)).show()
  else if type == "link"
    feed.append(link_to_html(post)).show()

image_to_html = (post) ->
  html = "
  <div class='post'>
    <li class='postbody'><img src='#{post.content}' />
      </br>
      <p>#{post.comment}</p>
      <p class='posted'>posted #{post.created_at} ago</p>
    </li>
  </div>
  "

link_to_html = (post) ->
  html = "
  <div class='post'>
    <li class='postbody'><a href=#{post.content} target='_blank'>#{post.content}</a>
      </br>
      <p>#{post.comment}</p>
      <p class='posted'>posted #{post.created_at} ago</p>
    </li>
  </div>
  "

text_to_html = (post) ->
  html = "
  <div class='post'>
    <li class='postbody'><p>#{post.content}</p>
      <p class='posted'>posted #{post.created_at} ago</p>
    </li>
  </div>
  "

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
        $("#feed").children() .remove()
        window.page_count = 0
        update()
      error: (response, status)->
        resp = $.parseJSON(response.responseText)
        $("##{klass}_errors").show()
        for error in resp.errors
          $("##{klass}_errors_list").html "<li>#{error}</li>"
    })

hasItems = (hash) ->
  for key in hash
    if hash.hasOwnProperty key
      return true
  false

jQuery ->
  $('.tab-body ul').children().hide()
  $('.tab-body ul').children().first().show()
  $('.tab-item').click ->
    $.namespace.activateTab(this['id'])
    tabId = "#{this['id']}-tab".toLowerCase()
    $('.tab-body ul').children().hide()
    $("##{tabId}").show()
    
  addSubmitHandler("text")
  addSubmitHandler("image")
  addSubmitHandler("link")
  window.page_count = 0
  update()

  $(window).scroll ->
    if $(window).scrollTop() > $(document).height() - $(window).height() - 50
      window.page_count++
      update()





