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
      $("#services").click
      setFlash("Added your github account")
    $("#github_true").click ->
      $("#services").click
      setFlash("Removed your github account")  
    $("#twitter_false").click ->
      $("#services").click
      setFlash("Added your twitter account")
    $("#twitter_true").click ->
      $("#services").click
      setFlash("Removed your twitter account") 
    $("#instagram_false").click ->
      $("#services").click
      setFlash("Added your instagram account")
    $("#instagram_true").click ->
      $("#services").click
      setFlash("Removed your instagram account") 

addServicesHandler = ->
  $('#services').click ->
    $.getJSON('/authentications', (response, status, jqxhr) ->
      providers = response['providers']
      for provider in providers
        $("##{provider[0]}_false").hide()
        $("##{provider[0]}_true").attr("href","/authentications/#{provider[1]}").show()
    )
    $.getJSON('/subscriptions', (response, status, jqxhr) ->
      renderRefeeds(response['subscriptions'])
    )
    pageSwap("#services-page")

renderRefeeds = (subscriptions) ->
  if subscriptions[0]
    $('#refeeds').html("<ul>")
    for subscription in subscriptions
      $('#refeeds').append("<li><a class='unfeed' data-feed-id='#{subscription['feed_id']}'>X</a>&nbsp;&nbsp;#{subscription['feed_name']}</li>")
    $('#refeeds').append("</ul>")
    addUnfeedHandlers()
  else
    $('#refeeds').text("None")

addUnfeedHandlers = ->
  $('a.unfeed').click ->
    id = $(this).attr('data-feed-id') 
    $.ajax(
      type: "DELETE",
      url:  "/subscriptions/"+id,
      data: { feed_id: id }
      success: (data) ->
        setFlash('Unsubscribe successful')
        renderRefeeds(data['subscriptions'])
      error: ->
        setError('Unsubscribe failed')
    )

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
    $.getJSON('/current_user', (response, status, jqXHR) ->
      responseHandler(response))
    @feeduser = $.feedengine.subdomain
    @currentuser = $.feedengine.current_user_name
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

getSubDomain = ->
  host_parts = window.location.host.split('.')
  unless host_parts[0] == 'simplefeed' || host_parts[0] == 'feedeng'
    $.feedengine.subdomain = host_parts[0]
  else
      $.feedengine.subdomain = null

responseHandler = (response) ->
  $.feedengine.current_user_name = response.display_name

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