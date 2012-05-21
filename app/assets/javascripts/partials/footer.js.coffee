$ ->
  $.ajax(
    url: "/footer.html",
    cache: true,
    format: "html",
    success: (html) ->
      $("footer").append(html).addClass('footer')
    )