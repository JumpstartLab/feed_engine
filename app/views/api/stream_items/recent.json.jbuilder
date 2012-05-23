  json.name            @user.display_name
  json.id              @user.id
  json.link            api_feed_url(@user)

  json.recent_items   @stream_items do |json, stream_item|
    json.(stream_item, :id, :created_at)
    json.type        stream_item.streamable.class.name
    json.image_url   stream_item.streamable.url if stream_item.streamable.is_a?(ImageItem)
    json.link_url    stream_item.streamable.url if stream_item.streamable.is_a?(LinkItem)
    json.body        stream_item.streamable.body if stream_item.streamable.is_a?(TextItem)
    json.comment     stream_item.streamable.comment if stream_item.streamable.is_a?(LinkItem) || stream_item.streamable.is_a?(ImageItem)
    json.feed        api_feed_url(stream_item.user)
    json.link        api_item_url(stream_item.streamable.user, stream_item.streamable.stream_items.first)
    json.refeed      stream_item.refeed
    json.refeed_link api_refeed_item_url(stream_item.user, stream_item)
  end
