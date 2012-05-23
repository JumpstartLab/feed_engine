jQuery ->
  addSubmitHandlers()
  addServicesHandler()
  integrationsHandler()

#### #### #### #### #### #### Spotlight, Backstage, PageSwap #### #### #### 

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

integrationsHandler = ->
    $("#github_false").click ->
      setFlash("Added your github account")
    $("#github_true").click ->
      setFlash("Removed your github account")  
    $("#twitter_false").click ->
      setFlash("Added your twitter account")
    $("#twitter_true").click ->
      setFlash("Removed your twitter account") 
    $("#instagram_false").click ->
      setFlash("Added your instagram account")
    $("#instagram_true").click ->
      setFlash("Removed your instgram account") 

addServicesHandler = ->
  $('#services').click ->
    $.getJSON('/authentications', (response, status, jqxhr) ->
      providers = response['providers']
      for provider in providers
        $("##{provider[0]}_false").hide()
        $("##{provider[0]}_true").attr("href","/authentications/#{provider[1]}").show()
    )
    pageSwap("#services-page")

addSubmitHandlers = ->
  $(".errors").hide()
  $(".post-form form .post-button").click ->
    $(".errors").hide()
    $("#image_preview").hide()
    $.feedengine.form = form = $(this).closest('form')
    formData = form.serialize()
    response = $.post("/posts", formData)
    response.success postSuccess
    response.error postFailed   

postSuccess = ->
  setFlash('Posted successfully')
  $.feedengine.form.clearForm()
  $("#feed").children().remove()
  new FeedPager($('#feed'))

postFailed = (response, status) ->
  resp = $.parseJSON(response.responseText)
  errors = $("##{$.feedengine.activeTabId.toLowerCase()}-tab .errors")
  errors.show()
  $(".errors_list").html(null)
  for error in resp["errors"]
    $(".errors_list").append "<li>#{error}</li>"

class FeedPager
  constructor:(feed=$('#all_posts')) ->
    @feeduser = $.feedengine.subdomain
    $.feedengine.current_feed = feed
    $.feedengine.current_pager = this
    @page=-1
    $(window).scroll(checkForBottom)
    @render()

  render: =>
    @page++
    $(window).unbind('scroll', checkForBottom)
    unless @feeduser
      $.getJSON('/posts', page: @page, renderPosts)
    else
      url = "posts/#{@feeduser.toString()}"
      $.getJSON(url, page: @page, renderPosts)

checkForBottom = ->
  if nearBottom()
    $.feedengine.current_pager.render()

nearBottom = ->
  $(window).scrollTop() > $(document).height() - $(window).height() - 50

renderPosts = (response, status, jqXHR) ->
    posts = response['posts']
    for post in posts
      type = post["type"]
      $.feedengine.current_feed.append Mustache.to_html($("##{type}_template").html(), post)
    $(window).scroll(checkForBottom) if posts && posts.length > 0