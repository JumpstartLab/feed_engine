json.type video.type
json.link_url video.link
json.comment video.comment
json.created_at video.created_at
json.id video.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(@user.display_name, video.id)
json.refeed video.regrowled?
json.refeed_link video.regrowl_link(request)