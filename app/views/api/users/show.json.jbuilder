json.name @user.display_name
json.id @user.id
json.private "false"
json.link feed_url(@user.display_name)
#json.items @user.posts do |json, post|
#end
json.most_recent @user.posts do |json, post| 
    json.(post, :body) if post.message?
    json.(post, :url, :description) if post.link? || post.image?
end

json.web_url root_url(subdomain: @user.display_name)