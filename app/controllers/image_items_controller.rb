class ImageItemsController < ApplicationController
  include DashboardControllerHelper
  before_filter :create_feed_items, :only => [:create]

  def create
    @image_item = current_user.image_items.new(params[:image_item])
    if @image_item.save
      @new_stream_item = current_user.stream_items.find(@image_item.to_param)
      x = render_to_string(:partial => "feed/item", :locals => { :item => @new_stream_item }, :layout => false )
      Pusher['new_channel'].trigger('hello', { :html => x,
        :stream_id => @new_stream_item.id } 
        )
      respond_to do |format|
        format.js { render :create }
      end
    end
    @text_item = TextItem.new
    @link_item = LinkItem.new
  end
end
