
  json.name            @user.display_name
  json.id              @user.id
  json.private         false
  json.link            v1_feeds_user_stream_items_path(@user)

  json.items do |json|
    json.pages         @stream_items.num_pages
    json.first_page    v1_feeds_user_stream_items_path(@user, :page => 1)
    json.last_page     v1_feeds_user_stream_items_path(@user, :page => @stream_items.num_pages)
    json.most_recent   @items do |json, item|
      json.(item, :id, :created_at)
      json.type        item.class.name
      json.image_url   item.url if item.is_a?(ImageItem)
      json.link_url    item.url if item.is_a?(LinkItem)
      json.body        item.body if item.is_a?(TextItem)
      json.comment     item.comment if item.is_a?(LinkItem) || item.is_a?(ImageItem)
      json.feed        api_feed_url(item.user)
      json.link        api_item_url(item.user, item.stream_items.first)
      json.refeed      false
      json.refeed_link ""
    end
  end
