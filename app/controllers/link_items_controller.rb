class LinkItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @link_item = current_user.link_items.new(params[:link_item])
    if @link_item.save
      @new_stream_item = current_user.stream_items.find(@link_item.to_param)
    end
    @text_item = TextItem.new
    @image_item = ImageItem.new
  end
end
