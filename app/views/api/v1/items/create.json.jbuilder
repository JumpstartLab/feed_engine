if @user
  json.name @user.display_name
  json.id @user.id
  json.private "false"
  json.link api_v1_items_url(@user.display_name)

  json.type @post.class.to_s
  json.(@post, :body) if @post.message?
  json.(@post, :url, :description) if @post.link? || @post.image?
  json.created_at @post.created_at
  json.id @post.id
  json.feed api_v1_items_url(@user.display_name)
  json.link api_v1_item_url(@user.display_name, @post.id)
  json.refeed "false"
  json.refeed_link ""
end
