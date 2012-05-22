jQuery ->
  addNavHandlers()

#### #### #### #### #### #### Spotlight, Backstage, PageSwap #### #### #### 

pageSwap = (id)->
  spotlightToBackstage()
  backstageToSpotlight(id)

backstageToSpotlight = (backstageId) ->
  $('#spotlight').append($(backstageId))

spotlightToBackstage = ->
  $('#backstage').append($('#spotlight').children())

addNavHandlers = ->
  navItems = ['#friends', '#home', '#signin', '#signup', '#settings']
  pageIDs = (id + '-page' for id in navItems)
  for id in navItems
    navHandler(id)

navHandler = (navItem) ->
  $(navItem).click ->
    pageSwap("#{navItem}-page")
