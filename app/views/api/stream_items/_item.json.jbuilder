json.(item)


json.type        item.class.name
json.image_url   item.url if item.is_a?(ImageItem)
json.link_url    item.url if item.is_a?(LinkItem)
json.body        item.body if item.is_a?(TextItem)
json.comment     item.comment if item.is_a?(LinkItem) || item.is_a?(ImageItem)
json.created_at  item.created_at
json.id          item.id
json.feed        "http://api.feedengine.com/feeds/#{item.user.display_name}"
json.link        api_item_url(item.user, item)
json.refeed      false
json.refeed_link ""
