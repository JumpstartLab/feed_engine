json.type link.type
json.link_url link.link
json.comment link.comment
json.created_at link.created_at
json.id link.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(@user.display_name, link.id)
json.refeed link.regrowled?
json.refeed_link link.regrowl_link(request)