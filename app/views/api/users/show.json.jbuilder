json.name @user.display_name
json.id @user.id
json.private "false"
json.link feed_url(@user.display_name)

json.items @user.items do |json, item|
  json.most_recent @user.items do |json, item| 
      json.(item, :post_type)
      json.(item.post, :body) if item.post.message?
      json.(item.post, :url, :description) if item.post.link? || item.post.image?
      json.(item, :created_at)
      json.(item, :id)
      json.feed feed_url(@user.display_name)
  end
end

json.web_url root_url(subdomain: @user.display_name)
#json.private @user.private
json.link feed_url(@user.display_name)

