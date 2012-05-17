jQuery ->
  if $('#posts').length
    new PostsPager()
    
class PostsPager
  constructor: (@page = 1) ->
    $.getJSON($('#posts').data('json-url'), page: @page, @render)
    $(window).scroll(@check)

  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#posts').data('json-url'), page: @page, @render)
      
  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 50

  render: (posts) =>
    for post in posts
      $('#posts').append Mustache.to_html($('#post_template').html(), post)
    $(window).scroll(@check) if posts && posts.length > 0
