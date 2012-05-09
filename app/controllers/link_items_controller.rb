class LinkItemsController < ApplicationController
  def new
    @link_item = LinkItem.new
  end

  def create
    @link_item = LinkItem.new(params[:link_item])

    if @link_item.save
      redirect_to dashboard_path, notice: 'Link was successfully created.'
    else
      @text_item = TextItem.new
      render :template => "dashboard/show"
    end
  end
end
