class LinkItemsController < ApplicationController
  def new
    @link_item = LinkItem.new
  end

  def create
    @link_item = current_user.link_items.new(params[:link_item])

    if @link_item.save
      redirect_to dashboard_path, notice: 'Link was successfully created.'
    else
      @text_item = TextItem.new
      @image_item = ImageItem.new
      render :template => "dashboard/show"
    end
  end
end
