json.array!(@items) do |json, item|
  json.(item, :id, :created_at)
  json.type        item.class.name
  json.image_url   item.url if item.is_a?(ImageItem)
  json.link_url    item.url if item.is_a?(LinkItem)
  json.body        item.body if item.is_a?(TextItem)
  json.comment     item.comment if item.is_a?(LinkItem) || item.is_a?(ImageItem)
  json.feed        "http://api.feedengine.com/feeds/#{item.user.display_name}"
  json.link        api_v1_feeds_user_stream_item_path(item.user, item.stream_items.first)
  json.refeed      false
  json.refeed_link ""
end
    #json.partial! "api/v1/feeds/stream_items/item", item: current_item
