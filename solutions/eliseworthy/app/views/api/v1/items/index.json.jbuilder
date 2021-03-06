json.name @user.display_name
json.id @user.id
json.private "false"
json.link api_v1_items_url(@user.display_name)

json.items do |json|
  json.pages @user.post_page_count
  unless @user.items.empty?
    json.first_page root_url(subdomain: @user.display_name, page: 1)
    json.last_page root_url(subdomain: @user.display_name, page: @user.post_page_count)
    json.most_recent @user.items.reverse.first(3) do |json, item| 
      json.(item, :post_type)
      json.(item.post, :body) if item.post.message?
      json.(item.post, :url, :description) if item.post.link? || item.post.image?
      json.(item, :created_at)
      json.(item, :id)
      json.feed api_v1_items_url(@user.display_name)
      json.link api_v1_item_url(@user.display_name, item.id)
      json.refeed "false"
      json.refeed_link ""
    end
    if @all
      json.all @user.items do |json, item|
        json.(item, :post_type)
        json.(item.post, :body) if item.post.message?
        json.(item.post, :url, :description) if item.post.link? || item.post.image?
        json.(item, :created_at)
        json.(item, :id)
        json.feed api_v1_items_url(@user.display_name)
        json.link api_v1_item_url(@user.display_name, item.id)
        json.refeed "false"
        json.refeed_link ""
      end
    end
    if @filtered_items
      json.filtered @filtered_items do |json, item|
        json.(item, :post_type)
        json.(item.post, :body) if item.post.message?
        json.(item.post, :url, :description) if item.post.link? || item.post.image?
        json.(item, :created_at)
        json.(item, :id)
        json.feed api_v1_items_url(@user.display_name)
        json.link api_v1_item_url(@user.display_name, item.id)
        json.refeed "false"
        json.refeed_link ""
      end
    end
  end
end

json.web_url root_url(subdomain: @user.display_name)
#json.private @user.private
json.link api_v1_items_url(@user.display_name)
