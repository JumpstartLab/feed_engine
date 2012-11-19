json.type github_event.type
json.image_url github_event.link
json.comment github_event.comment
json.created_at github_event.created_at
json.id github_event.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(@user.display_name, github_event)
json.refeed github_event.regrowled?
json.refeed_link github_event.regrowl_link(request)
