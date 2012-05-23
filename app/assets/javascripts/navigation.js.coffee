jQuery ->
  addNavHandlers()
  
addNavHandlers = ->
  navItems = ['#friends', '#home', '#signin', '#signup']
  pageIDs = (id + '-page' for id in navItems)
  for id in navItems
    navHandler(id)

navHandler = (navItem) ->
  $(navItem).click ->
    pageSwap("#{navItem}-page")