# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  # $(".refeed_ajax_link").each ->
  #   $(this).append "<input type=\"hidden\" value=\"" + access_token + "\" name=\"access_token\" />"

  # $(".refeed_ajax_link").bind "click", (e) ->
  #   e.preventDefault()
    
  #   $this = $(this)
  #   alert $(this).data("user")
  #   $.ajax
  #     type: "post"
  #     url: "http://api.feedengine.dev/feeds/" + "testuser" + "/stream_items/" + $(this).data("id") + "/refeeds.json?token=" + access_token

  #     success: (data) ->
  #       $this.parent().html("Post has been refeeded").addClass "label label-info"

  #     error: (evt) ->
  #       alert "unable to refeed"

# $(".refeed_link").live "click", (e) ->
#   e.preventDefault()
#   $this = $(this)
#   $.ajax
#     type: "post"
#     url: "/api/feeds/" + $(this).data("user") + "/items/" + $(this).data("id") + "/refeeds.json"
#     data:
#       access_token: access_token

#     success: (data) ->
#       $this.parent().html("Post has been refeeded").addClass "label label-info"

#     error: (evt) ->
#       alert "unable to refeed"

