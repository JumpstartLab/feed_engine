module DashboardControllerHelper
  def create_feed_items
    @stream_items = current_user.stream_items.order("created_at DESC").limit(5)
    @items = @stream_items.collect { |i| i.streamable}
  end
end
