jQuery ->
  setUsername()
  addSignupHandler()
  addSigninHandler()
  addLogoutHandler()
  addIntegrationHandlers()
  addSettingsHandlers()
  addResetPasswordHandler()

#### #### #### #### #### #### #### General #### #### #### #### #### #### 

setUsername = ->
  $.getJSON('/current_user', (response, status, jqXHR) ->
      email = response.email
      $.feedengine.current_user = email
      refreshAccountMenu email
  )

refreshAccountMenu =(email = $.feedengine.current_user) ->
  accountMenu = $('#account')
  $('#backstage').append($('#account ul'))
  if email
    accountMenu.append($('#auth'))
  else
    accountMenu.append($('#unauth'))

#### #### #### #### #### Spotlight, Backstage, PageSwap #### #### #### #### 

pageSwap = (id)->
  spotlightToBackstage()
  backstageToSpotlight(id)

backstageToSpotlight = (backstageId) ->
  $('#spotlight').append($(backstageId))

spotlightToBackstage = ->
  $('#backstage').append($('#spotlight').children())

setFlash = (message) ->
  $('#flash_message').text(message)
  $('#flash').slideDown().delay(2000).slideUp()

#### #### #### #### #### #### #### Signup #### #### #### #### #### #### 

addId = (element, id) ->
  $(element).attr('id', id)

addSignupHandler = ->
  addId('#signup-page .button', 'signup-submit')
  addId('#signup-page form', 'signup_form')
  $(".errors").hide()
  $('#signup-submit').click ->
    $(".errors").hide()
    form = $('#signup_form')
    formData = form.serialize()
    jqxhr = $.post("/signup", formData, "json")
    signupResponse(jqxhr, form)

signupResponse = (jqxhr, form) ->
  jqxhr.success ->
    email = $('#user_email').val()
    password = $('#user_password').val()
    firstLogin(email, password)
    form.clearForm()

  jqxhr.error (response, status) ->
    resp = $.parseJSON(response['responseText'])
    $('#signup-page .errors').show()
    $('#signup-page .errors ul').children().remove()
    for error in resp['errors'] 
      $('#signup-page .errors ul').append("<li>#{error}</li>")


firstLogin = (email, password) ->
  setFlash('Signup successful! Welcome to FeedEngine')
  $.feedengine.current_user = email
  jqxhr = $.post('/login', data: loginDataToJson(email, password) )
  jqxhr.success((data, status, jqxhr) ->
      refreshAccountMenu()
      integrateTwitter()
  )

loginDataToJson = (email, password) ->
  { 'email': email, 'password': password }

#### #### #### #### #### #### #### Signin #### #### #### #### #### #### 

addSigninHandler = ->
  $('#signin-submit').click ->
    form = $(this).closest('form')
    formData = form.serialize()
    jqxhr = $.post('/login', formData, 'json')
    signinResponse(jqxhr, form)

signinResponse = (jqxhr, form) ->  
  jqxhr.success( (response) ->
    form.clearForm()
    $.feedengine.current_user = response.email
    refreshAccountMenu()
    $('#dashboard').click()
    setFlash("Login Successful"))

  jqxhr.error (response, status) ->
    setFlash(response['responseText'])

#### #### #### #### #### Service Integration #### #### #### #### #### #### 

addIntegrationHandlers = ->
  addSkipHandlers()
  $('.integration_handler').click ->
    service = $(this).data('service')
    window.open("auth/#{service}")
    $(window).focus checkForAuthentication(service)
    $(window).unbind('focus')

addSkipHandlers = ->
  $('#skip_twitter').click ->
    pageSwap('#integrate_github')
  $('#skip_github').click ->
    pageSwap('#integrate_instagram')
  $('#skip_instagram').click ->
    $('#dashboard').click()

checkForAuthentication = (provider) ->
  response = $.getJSON("/checkauth/#{provider}")
  authResponse(response, provider)

authResponse = (response, provider) ->
  response.success (response, status) ->
    if response['auth']
      setFlash("Authentication with #{provider} successful!")
      $("#skip_#{provider}").click()
    else
      setFlash("Authentication unsuccessful")

  response.error( ->
    setFlash('Something went wrong :(')
  )

integrateTwitter = ->
  pageSwap('#integrate_twitter')

#### #### #### #### #### #### #### Logout #### #### #### #### #### #### 

logout = ->
  $.getJSON('/logout', (response, status, xhr) ->
    setFlash(response.text)
    setUsername()
    $('#home').click()
  )

addLogoutHandler = ->
  $('#logout').parent().click ->
    logout()

#### #### #### #### #### #### Password Change #### #### #### #### #### ####

addSettingsHandlers = ->
  $(".errors").hide()
  $('#settings-page .button').click ->
    $(".errors").hide()
    form = $('#settings-page form')
    formData = form.serialize()
    jqxhr = $.ajax(
      type: "PUT",
      url: "/user/update",
      data:formData)
    updateResponse(jqxhr, form)

updateResponse = (response, form) ->
  response.success ->
    setFlash("Password update successful")

  response.error (json_response) ->
    text = $.parseJSON(json_response['responseText'])
    $('#settings-page .errors').show()
    $('#settings-page .errors ul').children().remove()
    for error in text['errors'] 
      $('#settings-page .errors ul').append("<li>#{error}</li>")

################################ RESET PASSWORD ###############################

addResetPasswordHandler = ->
  $('#reset_password').click ->
    email = $('#signin-page #email').val()
    unless email
      setFlash("Please provide an email address to reset password")
    else
      $.post('/reset_password', email: email)





