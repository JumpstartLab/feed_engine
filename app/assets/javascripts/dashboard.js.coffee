jQuery ->
  addHandlers()
  homeHandler()

#### Spotlight, Backstage, PageSwap

pageSwap = (id)->
  spotlightToBackstage()
  backstageToSpotlight(id)

backstageToSpotlight = (backstageId) ->
  $('#spotlight').append($(backstageId))

spotlightToBackstage = ->
  $('#backstage').append($('#spotlight').children())

  #######

getSubDomain = ->
  host_parts = window.location.host.split('.')
  unless host_parts[0] == 'simplefeed' || host_parts[0] == 'feedeng'
    $.feedengine.subdomain = host_parts[0]
  else
      $.feedengine.subdomain = null

addHomeHandler = ->
  $('#home').click(homeHandler)

homeHandler = ->
  pageSwap('#home-page')
  getSubDomain()
  new FeedPager()

addDashboardHandler = ->
  $('#dashboard').click ->
    pageSwap("#dashboard-page")
    renderDashboard()


######################### DASHBOARD ############################

addTabMenuHandler = ->
  $('.tab-item').click ->
    $.feedengine.activateTab(this['id'])
    tabId = "#{this['id']}-tab".toLowerCase()
    $('.tab-body ul').children().hide()
    $("##{tabId}").show()

addPreviewHandler = ->
  $('#image_url').blur ->
    $('#image_preview').attr('src', $('#image_url').val()).show()

addSubLinkHandler = ->
  $('#sub_to_feed').click ->
    $.ajax(
      type: "POST",
      url:  "/subscriptions",
      data: { feed_name: $.feedengine.subdomain }
      success: ->
        setFlash('Subscribed successfully')
        $('a#sub_to_feed').hide()
      error: ->
        setError('Subscription failed')
    )

addHandlers = ->
  addPreviewHandler()
  addTabMenuHandler()
  addDashboardHandler()
  addHomeHandler()
  addSubLinkHandler()
  
renderDashboard = ->
  if $.feedengine.current_user
    $('.tab-body ul').children().hide()
    $('.tab-body ul').children().first().show()
    $('#feed').children().remove()
    $.feedengine.activateTab('Text')
    new FeedPager($('#feed'))
  else
    $('#signin').click()
    setFlash("Please login first.")

setFlash = (message) ->
  $('#flash_message').text(message)
  $('#flash').slideDown().delay(2000).slideUp()

addRefeedHandler = ->
  unless $.feedengine.current_user
    $('.refeed').hide()
  $('.refeed').click ->
    post_id = $(this).attr('id')
    $.ajax(
      type: 'POST',
      url: 'posts/refeeds',
      data: id:post_id,
      success: ->
        setFlash('Refed Successfully!')
      error: ->
        setFlash('Unsuccessful Refeed.OH NOES!')
      )
  
setError = (message) ->
  $('#error_message').text(message)
  $('#error').slideDown().delay(2000).slideUp()
  
class FeedPager
  constructor:(feed=$('#all_posts')) ->
    @feeduser = $.feedengine.subdomain
    $.feedengine.current_feed = feed
    $.feedengine.current_pager = this
    @page=-1
    $(window).scroll(checkForBottom)
    @render()
    @setSubscribeLink()

  render: =>
    @page++
    $(window).unbind('scroll', checkForBottom)
    unless @feeduser
      $.getJSON('/posts', page: @page, renderPosts)
    else
      url = "posts/#{@feeduser.toString()}"
      $.getJSON(url, page: @page, renderPosts)

  setSubscribeLink: =>
    $.getJSON('/current_user', (response, status, jqXHR) ->
        json_string = JSON.stringify(response)
        current_user_subdomain = JSON.parse(json_string).subdomain
        current_subdomain = getSubDomain()
        if current_subdomain && current_user_subdomain && current_subdomain != current_user_subdomain
          $('a#sub_to_feed').show()
        else
          $('a#sub_to_feed').hide()
    )
    
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
    addRefeedHandler()
