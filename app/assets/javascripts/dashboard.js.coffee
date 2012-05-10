jQuery ->
  if $('#posts').length
    new PostsPager()
    
class PostsPager
  constructor: ->
    $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      $(window).unbind('scroll', @check)
      alert 'near bottom'
      
  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50