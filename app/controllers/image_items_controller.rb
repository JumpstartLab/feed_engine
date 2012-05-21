class ImageItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @image_item = current_user.image_items.new(params[:image_item])
    @text_item = TextItem.new
    @link_item = LinkItem.new
    @image_item.save
  end
end
