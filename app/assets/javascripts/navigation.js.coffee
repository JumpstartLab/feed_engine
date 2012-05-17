setFlash = (message) ->
  $('#flash').text(message).fadeOut(1500)

class User
  constructor: (@email, @password) ->
    @authenticated = false
    @authenticate()

  authenticate: =>
    data = @infoToJSON()
    $.post('/login',
      data: data,
      success: (data, status, xhr) =>
        @authenticated = true
        renderDashboard()
    )

  infoToJSON: =>
    { user: { email: @email, password: @password }}

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
  setCSRFToken()
  navItems = ['#friends', '#feeds', '#home', '#signin', '#signup']
  pageIDs = (id + '-page' for id in navItems)
  
  for id in navItems
    navHandler(id)
  addDashboardHandler()
  addHandlers()
  $.feedengine = {
    current_user: null
  }

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
  $(".post-form form .post-button").click ->
    $(".errors").hide()
    form = $(this).closest('form')
    formData = form.serialize()
    $.ajax(
      type: "POST",
      url: "/posts",
      data: formData
      success: ->
        setFlash('Posted successfully')
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
  $('#signup-submit').click ->
    $(".errors").hide()
    form = $(this).closest('form')
    formData = form.serialize()
    jqxhr = $.post("/signup", formData, "json")
    jqxhr.success( ->
      setFlash('Signup successful! Welcome to FeedEngine')
      alert "#{$('#user_email')}"
      email = $('#user_email').val()
      alert email.toString()
      password = $('#user_password').val()
      alert "#{email} #{password}"
      $.feedengine['current_user'] = new User(email, password) 
      form.clearForm()
      new PostsPager())
    jqxhr.error((response, status) ->
        resp = $.parseJSON(response['responseText'])
        $('#signup-page .errors').show()
        for error in resp['errors'] 
          $('#signup-page .errors ul').append("<li>#{error}</li>")
        )

addSigninHandler = ->
  $('#signin-submit').click ->
    form = $(this).closest('form')
    formData = form.serialize()
    setCSRFToken()
    jqxhr = $.post('/login', formData, 'json')
    jqxhr.success( ->
      alert
      renderDashboard())
    jqxhr.error( (response, status)->
      setFlash(response['responseText'])

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
  addSigninHandler()

renderDashboard = ->
  $('.tab-body ul').children().hide()
  $('.tab-body ul').children().first().show()
  $('#feed').children().remove()
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

