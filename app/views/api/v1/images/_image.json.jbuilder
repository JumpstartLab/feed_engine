json.type image.type
json.image_url image.link
json.comment image.comment
json.created_at image.created_at
json.id image.id
json.feed "http://api.#{request.domain}/feeds/#{@user.display_name}"
json.link image_url(image)
json.refeed ""
json.refeed_link ""
