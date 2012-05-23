json.type tweet.type
json.link_url tweet.link
json.comment tweet.comment
json.created_at tweet.created_at
json.id tweet.id
json.feed v1_url(@user.display_name)
json.link v1_growl_url(@user.display_name, tweet.id)
json.refeed tweet.regrowled?
json.refeed_link tweet.regrowl_link(request)