jQuery ->
  $("#link_link").focusout( ->
    $.post api_path + "meta_data", url: $("#link_link").val(), token: (authentication_token), dataType: 'json', ((data) ->
       # Setting up the form
       $("#link_title").val(data.title)
       $("#link_description").val(data.description)
       $("#link_thumbnail_url").val(data.thumbnail_url)

       # Helping the user
       $("#link_show").show()
       $("#title").html(data.title)
       $("#description").html(data.description)
       $("#thumbnail").attr(src:data.thumbnail_url)
       $("#loading").hide()
    ), "json"
  )
  $("#image_url").focusout( ->
    $(".comments.comment_image").show()
    $("#title_image").show()
    $("#image_preview").attr("src", $("#image_url").val())
  )
