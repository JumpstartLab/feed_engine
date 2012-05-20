class TextItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:new, :create]

  def new
    @text_item = TextItem.new
  end

  def create
    @text_item = current_user.text_items.new(params[:text_item])
    @link_item = LinkItem.new
    @image_item = ImageItem.new
    @text_item.save
      #redirect_to dashboard_path, notice: 'Post was successfully created.'
    #else
      #@link_item = LinkItem.new
      #@image_item = ImageItem.new
      #@link_item = LinkItem.new
      #@image_item = ImageItem.new
      #render :template => "dashboard/show"
    #end
  end

  def show
  end
end
