class TextItemsController < ApplicationController

  def new
    @text_item = TextItem.new
  end

  def create
    @text_item = current_user.text_items.new(params[:text_item])
    if @text_item.save
#       Pusher['test_channel'].trigger('greet', {
#   :greeting => "#{@text_item.body}" 
# })
      redirect_to dashboard_path, notice: 'Post was successfully created.'
    else
      @link_item = LinkItem.new
      @image_item = ImageItem.new
      render :template => "dashboard/show"
    end
  end

  def show
  end
end
