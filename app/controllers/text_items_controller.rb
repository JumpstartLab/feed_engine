class TextItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @text_item = current_user.text_items.new(params[:text_item])
    if @text_item.save
      @new_stream_item = current_user.stream_items.find(@text_item.to_param)
    end
    @link_item = LinkItem.new
    @image_item = ImageItem.new
  end
end