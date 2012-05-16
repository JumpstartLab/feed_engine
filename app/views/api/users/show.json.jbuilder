json.name @user.display_name
json.id @user.id
json.private "false"
json.link feed_url(@user.display_name)

json.items do |json|
  json.pages @user.post_page_count
  json.first_page root_url(subdomain: @user.display_name, page: 1)
  json.last_page root_url(subdomain: @user.display_name, page: @user.post_page_count)
  json.most_recent @user.items[-3..-1] do |json, item| 
      json.(item, :post_type)
      json.(item.post, :body) if item.post.message?
      json.(item.post, :url, :description) if item.post.link? || item.post.image?
      json.(item, :created_at)
      json.(item, :id)
      json.feed feed_url(@user.display_name)
      json.link feed_item_url(@user.display_name, item.id)
      json.refeed "false"
      json.refeed_link ""
  end
end


json.web_url root_url(subdomain: @user.display_name)
#json.private @user.private
json.link feed_url(@user.display_name)

