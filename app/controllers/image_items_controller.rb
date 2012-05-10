class ImageItemsController < ApplicationController
  def create
    @image_item = current_user.image_items.new(params[:image_item])

    if current_user.save
      redirect_to dashboard_path, notice: 'Image was successfully created.'
    else
      @text_item = TextItem.new
      @link_item = LinkItem.new
      render :template => "dashboard/show"
    end
  end
end
