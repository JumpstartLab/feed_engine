json.type message.type
json.comment message.comment
json.created_at message.created_at
json.id message.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(@user.display_name, message.id)
json.refeed message.regrowled?
json.refeed_link message.regrowl_link(request)