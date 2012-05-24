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

######  ######  ######  ######  ######  ######  ######  ######  ######  ######
                                                
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

setError = (message) ->
  $('#error_message').text(message)
  $('#error').slideDown().delay(2000).slideUp()

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
        setFlash('Refed successfully!')
      error: ->
        setError('Unsuccessful refeed.')
      )
    $('.posted').append("")
  
addPointsHandler = ->
  $(".addpoints").click ->
      postid = $(this).attr('id')
      $.ajax(
        type: 'POST'
        url: 'points'
        data: id:postid
        success: (response) ->
          unless response["value"]
            changePoints(postid)
          else
            visitorPointsHandler(postid)
      )
      return false

changePoints = (postid) ->
  json = $.getJSON("/pointscount/#{postid}")
  json.success( (response) ->
    new_points = response.points_count
    $("#points_#{postid}").text("#{new_points}")
  )

responseHandler = (response) ->
  $.feedengine.current_user_name = response.display_name

visitorPointsHandler = (postid) ->
  setFlash "You must login or create an account to post"

class FeedPager
  constructor:(feed=$('#all_posts')) ->
    $.getJSON('/current_user', (response, status, jqXHR) ->
      responseHandler(response))
    @feeduser = $.feedengine.subdomain
    @currentuser = $.feedengine.current_user_name
    alert @currentuser
    $.feedengine.current_feed = feed
    $.feedengine.current_pager = this
    @page=-1
    $(window).scroll(checkForBottom)
    @render()
    @setSubscribeLink()

  render: =>
    @page++
    $(window).unbind('scroll', checkForBottom)
    if @currentuser
      url = "posts/#{@currentuser}"
      $.getJSON(url, page: @page, renderPosts)
    else if @feeduser
      url = "posts/#{@feeduser.toString()}"
      $.getJSON(url, page: @page, renderPosts)
    else
      $.getJSON('/posts', page: @page, renderPosts)

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

changePoints = (postid) ->
  json = $.getJSON("/pointscount/#{postid}")
  json.success( (response) ->
    new_points = response.points_count
    $("#points_#{postid}").text("#{new_points}")
  )

renderPosts = (response, status, jqXHR) ->
    posts = response['posts']
    for post in posts
      type = post["type"]
      $.feedengine.current_feed.append Mustache.to_html($("##{type}_template").html(), post)
      changePoints(post["id"])
    $(window).scroll(checkForBottom) if posts && posts.length > 0
    addPointsHandler()
    addRefeedHandler()
