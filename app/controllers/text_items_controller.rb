class TextItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @text_item = current_user.text_items.new(params[:text_item])
    @text_item.save
    @link_item = LinkItem.new
    @image_item = ImageItem.new
  end
end