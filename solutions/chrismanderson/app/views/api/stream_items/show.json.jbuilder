json.(@stream_item, :id, :created_at)


json.type        @item.class.name
json.image_url   @item.url if @item.is_a?(ImageItem)
json.link_url    @item.url if @item.is_a?(LinkItem)
json.body        @item.body if @item.is_a?(TextItem)
json.comment     @item.comment if @item.is_a?(LinkItem) || @item.is_a?(ImageItem)
json.feed        api_feed_url(@stream_item.user)
json.link        api_item_url(@stream_item.user, @stream_item)
json.refeed      @stream_item.refeed
json.refeed_link api_refeed_item_url(@stream_item.user, @stream_item)


