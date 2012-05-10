jQuery ->
  $("#link_link").focusout( ->
    $("#loading").toggle()
    $.post "/api/v1/meta_data", url: $("#link_link").val(), dataType: 'json', ((data) ->
       $("#link_title").val(data.title)
       $("#link_description").val(data.description)
       $("#link_thumbnail_url").val(data.thumbnail_url)

       $("#title").html(data.title).show()
       $("#description").html(data.description).show()
       $("#thumbnail").attr(src:data.thumbnail_url).show()
       $("#loading").toggle()
    ), "json"
  )