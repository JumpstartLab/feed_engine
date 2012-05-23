json.type image.type
json.image_url image.link
json.comment image.comment
json.created_at image.created_at
json.id image.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(@user.display_name, image.id)
json.refeed image.regrowled?
json.refeed_link image.regrowl_link(request)
