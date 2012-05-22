jQuery ->
  addNavHandlers()
  addDashboardHandler()
  addHandlers()
  servicesHandler()
  integrationsHandler()
  $.feedengine = {
    subdomain: null,
    form: null,
    current_user: null,
    activeTabId: null,
    activateTab: (tabId)->
      $(".errors").hide()
      if $.feedengine.activeTabId
        $("##{$.feedengine.activeTabId}").removeClass('selected')
      $("##{tabId}").addClass('selected')
      $.feedengine.activeTabId = tabId
  }
  setUsername()
  getSubDomain()
  new FeedPager()

getSubDomain = ->
  host_parts = window.location.host.split('.')
  unless host_parts[0] == window.location.host
    $.feedengine.subdomain = host_parts[0]
  else
    $.feedengine.subdomain = null





















setFlash = (message) ->
  $('#flash_message').text(message)
  $('#flash').slideDown().delay(2000).slideUp()
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
    pageSwap("#{navItem}-page")


integrationsHandler = ->
  services = ["github", "twitter", "instagram"]
  for service in services
    $("##{service}_false").click ->
      setFlash("Added your ##{service} account")
    $("##{service}_true").click ->
      setFlash("Removed your ##{service} account")  


servicesHandler = ->
  $('#services').click ->
    $.getJSON('/authentications', (response, status, jqxhr) ->
      providers = response['providers']
      for provider in providers
        $("##{provider[0]}_false").hide()
        $("##{provider[0]}_true").attr("href","/authentications/#{provider[1]}").show()
    )
    pageSwap("#services-page")


addDashboardHandler = ->
  $('#dashboard').click ->
    pageSwap("#dashboard-page")
    renderDashboard()

addNavHandlers = ->
  navItems = ['#friends', '#feeds', '#home', '#signin', '#signup']
  pageIDs = (id + '-page' for id in navItems)
  
  for id in navItems
    navHandler(id)


######################### DASHBOARD ############################

addSubmitHandlers = ->
  $(".errors").hide()
  $(".post-form form .post-button").click ->
    $(".errors").hide()
    $("#image_preview").hide()
    $.feedengine.form = form = $(this).closest('form')
    formData = form.serialize()
    $.ajax(
      type: "POST",
      url: "/posts",
      data: formData
      success: ->
        setFlash('Posted successfully')
        $.feedengine.form.clearForm()
        $("#feed").children().remove()
        new PostsPager()
      error: (response, status) ->
        resp = $.parseJSON(response.responseText)
        errors = $("##{$.feedengine.activeTabId.toLowerCase()}-tab .errors")
        errors.show()
        $(".errors_list").html(null)
        for error in resp["errors"]
          $(".errors_list").append "<li>#{error}</li>"
    )

addSignupHandler = ->
  $(".errors").hide()
  $('#signup-submit').click ->
    $(".errors").hide()
    form = $(this).closest('form')
    formData = form.serialize()
    jqxhr = $.post("/signup", formData, "json")
    jqxhr.success( ->
      email = $('#user_email').val()
      password = $('#user_password').val()
      firstLogin(email, password)
      form.clearForm()
    )
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

addFlashHandler = ->
  $('#flash').click ->
    $(this).hide()

addHandlers = ->
  addSubmitHandlers()
  addPreviewHandler()
  addTabMenuHandler()
  addSignupHandler()
  addSigninHandler()
  addLogoutHandler()
  addIntegrationHandlers()
  addFlashHandler()

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
  constructor: (@feeduser=null)->
    @page=-1
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


class FeedPager
  constructor: ()->
    @feeduser= $.feedengine.subdomain
    @page=-1
    $(window).scroll(@check)
    @render()

  check: =>
    if @nearBottom()
      @render()

  render: =>
    @page++
    $(window).unbind('scroll', @check)
    unless @feeduser
      $.getJSON('/posts', page: @page, @renderPosts)
    else
      $.getJSON('/posts/'+ @feeduser.toString(), page: @page, @renderPosts)


  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50

  renderPosts: (response, status, jqXHR) =>
    posts = response['posts']
    for post in posts
      type = post["type"]
      $('#all_posts').append Mustache.to_html($("##{type}_template").html(), post)
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

firstLogin = (email, password) ->
  setFlash('Signup successful! Welcome to FeedEngine')
  $.feedengine.current_user = email
  jqxhr = login(email, password)
  jqxhr.success((data, status, jqxhr) ->
      refreshAccountMenu()
      integrateTwitter()
  )

login = (email, password) ->
  $.post('/login',
    data: loginDataToJson(email, password)
  )

loginDataToJson = (email, password) ->
  { 'email': email, 'password': password }

addIntegrationHandlers = ->
  skipHandlers()
  $('.integration_handler').click ->
    service = $(this).data('service')
    window.open("auth/#{service}")
    checkForAuthentication(service)

skipHandlers = ->
  $('#skip_twitter').click ->
    pageSwap('#integrate_github')
  $('#skip_github').click ->
    pageSwap('#integrate_instagram')
  $('#skip_instagram').click ->
    $('#dashboard').click()

checkForAuthentication = (provider) ->
  $(window).focus ->
    response = $.getJSON("/checkauth/#{provider}")
    response.success((response, status) ->
      if response['auth']
        setFlash("Authentication with #{provider} successful!")
        $("#skip_#{provider}").click()
      else
        setFlash("Authentication unsuccessful")
    )
    response.error( ->
      setFlash('Something went wrong :(')
    )
    $(window).unbind('focus', checkForAuthentication)

integrateTwitter = ->
  pageSwap('#integrate_twitter')

pageSwap = (id)->
  spotlightToBackstage()
  backstageToSpotlight(id)

backstageToSpotlight = (backstageId) ->
  $('#spotlight').append($(backstageId))

refreshAccountMenu =(email = $.feedengine.current_user) ->
  accountMenu = $('#account')
  $('#backstage').append($('#account ul'))
  if email
    accountMenu.append($('#auth'))
  else
    accountMenu.append($('#unauth'))
