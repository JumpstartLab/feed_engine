class ImageItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @image_item = current_user.image_items.new(params[:image_item])
    if @image_item.save
      @new_stream_item = current_user.stream_items.find(@image_item.to_param)
    end
    @text_item = TextItem.new
    @link_item = LinkItem.new
  end
end
