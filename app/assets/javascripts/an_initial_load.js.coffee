jQuery ->
    initializeNamespace()
    addFlashHandler()

#### #### #### #### #### #### Spotlight, Backstage, PageSwap #### #### #### 

pageSwap = (id)->
  spotlightToBackstage()
  backstageToSpotlight(id)

backstageToSpotlight = (backstageId) ->
  $('#spotlight').append($(backstageId))

spotlightToBackstage = ->
  $('#backstage').append($('#spotlight').children())

#### #### #### #### #### #### Namespace #### #### #### #### #### #### #### 

initializeNamespace = ->
  $.feedengine = {
    subdomain: null,
    form: null,
    current_user: null,
    activeTabId: null,
    current_feed: $('#all_posts'),
    current_pager: null,
    activateTab: (tabId)->
      $(".errors").hide()
      if $.feedengine.activeTabId
        $("##{$.feedengine.activeTabId}").removeClass('selected')
      $("##{tabId}").addClass('selected')
      $.feedengine.activeTabId = tabId
  }

#### #### #### #### #### #### Flash #### #### #### #### #### #### #### ####

addFlashHandler = ->
  $('#flash').click ->
    $(this).hide()

setFlash = (message) ->
  $('#flash_message').text(message)
  $('#flash').slideDown().delay(2000).slideUp()