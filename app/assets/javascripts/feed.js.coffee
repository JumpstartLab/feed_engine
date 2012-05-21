# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

waiting = false
jQuery ->
  localStorage.setItem("nextPage", 2)
  $(window).scroll ->
    url = $('.pagination .next_page a').attr('href')
    if $(window).scrollTop() > $(document).height() - $(window).height() - 25
      if url? && !waiting
        $('#pagination-div').text("Fishing up more trouts!")
        waiting = true
        #alert url
        $.getScript(url, (data, textStatus, jqxhr) ->
          waiting = false)
    else if !url? && !waiting
        $('#pagination-div').text("Looks like this stream is fished dry")
  $(window).scroll

jQuery ->
  $('.refeed_ajax_link').each (i, el) ->
    $(el).data("title", "Retrout?")
    $(el).data("content", "Click to retrout this item!")
  $('.refeed_ajax_link').popover({ offset: -500,placement: 'left'})

  $(".refeed_ajax_link").live "click", (e) ->
    e.preventDefault()
    $('.refeed_ajax_link').popover('hide')
    $this = $(this)

    $.ajax
      type: "post"
      url: "/feeds/" + $(this).data('author') + "/stream_items/" + $(this).data('id') + "/refeeds.json?token=" + access_token

      success: (data) ->
        $this.append("Post has been retrouted!").delay(3000).fadeOut(1000)

      error: (evt) ->
        $this.parent().append("You've already retrouted this.").addClass "label label-info"

$(document).ready ->
  $("form[data-remote]").each ->
    $(this).append "<input type=\"hidden\" value=\"" + access_token + "\" name=\"access_token\" />"

  $("form[data-remote]").each ->
    $(this).bind "ajax:success", (e) ->
      form_success $(this)

    $(this).bind "ajax:error", (evt, xhr) ->
      form_errors $(this), xhr
