setFlash = (message) ->
  $('#flash').show().text(message).fadeOut(3700)

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
        $('#dashboard').click()
    ) 

  infoToJSON: =>
    { email: @email, password: @password }

setUsername = ->
  $.getJSON('/current_user', (response, status, jqXHR) ->
      json_string = JSON.stringify(response)
      email = JSON.parse(json_string).email
      $.feedengine.current_user = email
      refreshAccountMenu email
  )

spotlightToBackstage = ->
  $('#backstage').append($('#spotlight').children())

navHandler = (navItem) ->
  $(navItem).click ->
    spotlightToBackstage()
    $('#spotlight').append($("#{navItem}-page"))





servicesHandler = ->
  $('#services').click ->
    spotlightToBackstage()
    $.getJSON('/authentications', (response, status, jqxhr) ->
      providers = response['providers']
      for provider in providers
        $("##{provider[0]}_false").hide()
        $("##{provider[0]}_true").attr("href","/authentications/#{provider[1]}").show()
    )
    $('#spotlight').append($("#services-page"))


addDashboardHandler = ->
  $('#dashboard').click ->
    spotlightToBackstage()
    $('#spotlight').append($("#dashboard-page"))
    renderDashboard()

setCSRFToken = ->
  $.ajaxSetup(
    beforeSend: ( xhr ) ->
      token = '<%= form_authenticity_token.to_s %>'
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
  servicesHandler()
  $.feedengine = {
    current_user: null,
    activeTabId: null,
    activateTab: (tabId)->
      if $.feedengine.activateTabId
        $("##{$.feedengine.activateTabId}").removeClass('selected')
      $("##{tabId}").addClass('selected')
      $.feedengine.activateTabId = tabId
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
      $.feedengine.current_user = new User(email, password).email
      form.clearForm())
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
    jqxhr.success( (response) ->
      form.clearForm()
      $.feedengine.current_user = response.email
      refreshAccountMenu()
      $('#dashboard').click()
      setFlash("Login Successful")
    )

    jqxhr.error( (response, status)->
      setFlash(response['responseText'])
    )

addTabMenuHandler = ->
  $('.tab-item').click ->
    $.feedengine.activateTab(this['id'])
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
  if $.feedengine.current_user
    $('.tab-body ul').children().hide()
    $('.tab-body ul').children().first().show()
    $('#feed').children().remove()
    $.feedengine.activateTab('Text')
    new PostsPager()
  else
    $('#signin').click()
    setFlash("Please login first.")

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
      console.log $("##{type}_template").html()
      $("#feed").append Mustache.to_html($("##{type}_template").html(), post)
    $(window).scroll(@check) if posts && posts.length > 0


################################ Account Switching ###################

logout = ->
  $.getJSON('/logout', (response, status, xhr) ->
    json_string = JSON.stringify(response)
    json_hash = JSON.parse(json_string)
    json_hash.text
    setFlash(json_hash.text)
    setUsername()
    $('#home').click()
  )

refreshAccountMenu =(email = $.feedengine.current_user) ->
  accountMenu = $('#account')
  $('#backstage').append($('#account ul'))
  if email
    accountMenu.append($('#auth'))
  else
    accountMenu.append($('#unauth'))
