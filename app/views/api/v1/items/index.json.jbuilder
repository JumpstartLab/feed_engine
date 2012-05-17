json.items @items do |json, item|
  json.type item.post_type
  json.(item.post, :body) if item.post.message?
  json.(item.post, :url, :description) if item.post.link? || item.post.image?
  json.created_at item.created_at
  json.id item.id
  json.feed api_v1_items_url(@user.display_name)
  json.link api_v1_item_url(@user.display_name, item.id)
  json.refeed "false"
  json.refeed_link ""
end
