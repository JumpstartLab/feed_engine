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

addHandlers = ->
  addPreviewHandler()
  addTabMenuHandler()
  addDashboardHandler()
  addHomeHandler()

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
    $.feedengine.current_feed = $('#all_posts')
    unless @feeduser
      $.getJSON('/posts', page: @page, renderPosts)
    else
      $.getJSON('/posts/'+ @feeduser, page: @page, renderPosts)

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