class User
  constructor: (@email, @password) ->
    @authenticated = false
    @authenticate()

  authenticate: =>
    # data = @infoToJSON()
    # $.ajax(
    #   url: '/users/sign_in',
    #   method: 'POST',
    #   dataType: 'json',
    #   data: data,
    #   success: (data, status, xhr) =>
    #     @authenticated = true
    #     renderDashboard()
    # )

  infoToJSON: =>
    { user: { email: @email, password: @password } }

spotlightToBackstage = ->
  $('#backstage').append($('#spotlight').children())

navHandler = (navItem) ->
  $(navItem).click ->
    spotlightToBackstage()
    $('#spotlight').append($("#{navItem}-page"))

addDashboardHandler = ->
  $('#dashboard').click ->
    spotlightToBackstage()
    $('#spotlight').append($("#dashboard-page"))
    renderDashboard()

setCSRFToken = ->
  $.ajaxSetup(
    beforeSend: ( xhr ) ->
      token = $('meta[name="csrf-token"]').attr('content')
      if token
        xhr.setRequestHeader('X-CSRF-Token', token) 
  )

jQuery ->
  $.feedengine = {
    current_user: new User('tyre77@gmail.com', 'hungry')
  }
  setCSRFToken()
  navItems = ['#friends', '#feeds', '#home', '#signin', '#signup']
  pageIDs = (id + '-page' for id in navItems)
  
  for id in navItems
    navHandler(id)
  addDashboardHandler()



######################### DASHBOARD ############################





$.namespace = {
  activeTabId: null,
  activateTab: (tabId)->
    if $.namespace.activateTabId
      $("##{$.namespace.activateTabId}").removeClass('selected')
    $("##{tabId}").addClass('selected')
    $.namespace.activateTabId = tabId
}

addSubmitHandlers = ->
  $(".errors").hide()
  $(".post-form form .button").click ->
    $(".errors").hide()
    form = $(this).closest('form')
    formData = form.serialize()
    $.ajax(
      type: "POST",
      url: "/posts",
      data: formData
      success: ->
        $('#flash').text('Posted successfully')
        form.clearForm()
        $("#feed").children().remove()
        new PostsPager()
      error: (response, status) ->
        resp = $.parseJSON(response.responseText)
        $(".errors", form).show()
        for error in resp.errors
          $(".errors_list", form).html "<li>#{error}</li>"
    )

addSignupHandler = ->
  $(".errors").hide()
  $('#signup-page .button').click ->
    alert "hello"
    $(".errors").hide()
    form = $(this).closest('form')
    formData = form.serialize()
    $.ajax(
      type: "POST",
      url: "/signup",
      data: formData
      success: ->
        $('#flash').text('Signup successful! Welcome to FeedEngine')
        form.clearForm()
        new PostsPager()
      error: (response, status) ->
        resp = $.parseJSON(response.responseText)
        $(".errors", form).show()
        for error in resp.errors
          $(".errors_list", form).html "<li>#{error}</li>"
      )


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
  addSubmitHandlers()
  addPreviewHandler()
  addTabMenuHandler()
  addSignupHandler()

renderDashboard = ->
  $('.tab-body ul').children().hide()
  $('.tab-body ul').children().first().show()
  addHandlers()
  $.namespace.activateTab('Text')
  new PostsPager()

class PostsPager
  constructor: (@page=-1)->
    $(window).scroll(@check)
    @render()

  check: =>
    if @nearBottom()
      @render()

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
    $(window).scroll(@check) if posts && posts.length > 0

