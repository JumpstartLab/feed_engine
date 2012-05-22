class LinkItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @text_item = TextItem.new
    @image_item = ImageItem.new
    @link_item = current_user.link_items.new(params[:link_item])
    @link_item.save
  end
end
