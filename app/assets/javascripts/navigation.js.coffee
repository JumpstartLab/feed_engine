setFlash = (message) ->
  $('#flash').show().text(message).fadeOut(4500)

class User
  constructor: (@email, @password) ->
    @authenticated = false

  authenticate: =>
    data = @infoToJSON()
    $.post('/login',
      data: data,
      success: (data, status, xhr) =>
        @authenticated = true
        renderDashboard()
    )

  infoToJSON: =>
    { email: @email, password: @password }

setUsername = ->
  email = null
  $.getJSON('/current_user', (response, status, jqXHR) ->
      json_string = JSON.stringify(response)
      json_hash = JSON.parse(json_string)
      refreshAccountMenu json_hash.email
  )
  email

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

addNavHandlers = ->
  navItems = ['#friends', '#feeds', '#home', '#signin', '#signup']
  pageIDs = (id + '-page' for id in navItems)
  
  for id in navItems
    navHandler(id)

jQuery ->
  setCSRFToken()
  addNavHandlers()
  addDashboardHandler()
  addHandlers()
  $.feedengine = {
    current_user: null
  }
  setUsername()

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
    $("#image_preview").hide()
    form = $(this).closest('form')
    formData = form.serialize()
    setCSRFToken()
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
      email = $('#user_email').val()
      password = $('#user_password').val()
      $.feedengine.current_user = new User(email, password)
      setUsername()
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
      setUsername()
      renderDashboard())
    jqxhr.error( (response, status)->
      setFlash(response['responseText'])
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

addLogoutHandler = ->
  $('#logout').parent().click ->
    logout()

addHandlers = ->
  addSubmitHandlers()
  addPreviewHandler()
  addTabMenuHandler()
  addSignupHandler()
  addSigninHandler()
  addLogoutHandler()

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


################################ Account Switching ###################

logout = ->
  $.getJSON('/logout', (response, status, xhr) ->
    json_string = JSON.stringify(response)
    alert json_string
    json_hash = JSON.parse(json_string)
    json_hash.text
    setFlash(json_hash.text)
    setUsername()
  )

refreshAccountMenu =(email) ->
  accountMenu = $('#account')
  $('#backstage').append($('#account ul'))
  alert email
  if email
    accountMenu.append($('#auth'))
  else
    accountMenu.append($('#unauth'))
