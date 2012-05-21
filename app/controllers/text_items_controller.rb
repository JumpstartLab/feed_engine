class TextItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:new, :create]

  def new
    @text_item = TextItem.new
  end

  def create
    @text_item = current_user.text_items.new(params[:text_item])
    @text_item.save
    @link_item = LinkItem.new
    @image_item = ImageItem.new
  end

  def show
  end
end