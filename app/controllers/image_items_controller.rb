class ImageItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @image_item = current_user.image_items.new(params[:image_item])

    if @image_item.save
      redirect_to dashboard_path, notice: 'Image was successfully created.'
    else
      @text_item = TextItem.new
      @link_item = LinkItem.new
      render :template => "dashboard/show"
    end
  end
end
