json.type instagram_photo.type
json.image_url instagram_photo.link
json.comment instagram_photo.comment
json.created_at instagram_photo.created_at
json.id instagram_photo.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(id: instagram_photo.id)
json.refeed instagram_photo.regrowled?
json.refeed_link instagram_photo.regrowl_link(request)