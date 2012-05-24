jQuery ->
  if $('#posts').length
    new PostsPager()

  imageUrlValidation = (value, element) ->
    @optional(element) || new RegExp("^https?://.+\.(png|jpe?g|gif|bmp)", "i").test(value)

  $.validator.addMethod("imageUrl", imageUrlValidation, "Please enter a valid image url")

  $("form[name=image-post]").validate(
    rules:
      "image_post[external_image_url]":
        required: (element) ->
          $("#image_post_image").val() == ""
        imageUrl: (element) ->
          $("#image_post_image").val() == ""
  )
  $("form[name=text-message]").validate(
    rules:
      "text_post[title]":
        required: true
      "text_post[body]":
        required: true
  )
  $("form[name=link-post]").validate(
    rules:
      "link_post[url]":
        required: true
        url: true
      "link_post[description]":
        required: true
  )

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
      type = post.type.underscore()
      template = $("##{type}_template").html()
      $('#posts').append Mustache.to_html(template, post)
    $(window).scroll(@check) if posts.length > 0

