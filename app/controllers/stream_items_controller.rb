class StreamItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @stream_item = current_user.stream_items.new(:streamable_id => params[:streamable_id],
                                                 :streamable_type => params[:streamable_type])
    #raise @stream_item.inspect
    if @stream_item.save
      redirect_to :root, :notice => "You retrouted #{@stream_item.author.display_name}. Nice job!"
    else
    raise @stream_item.errors.inspect
      redirect_to :root, :alert => "CAST YOUR LINE AGAIN"
    end
  end
end
