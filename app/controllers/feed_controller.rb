class FeedController < ApplicationController
  def show
    if current_user 
      @stream_items = current_user.stream_items.order("created_at DESC").page(params[:page]).per(12)
      @items = StreamItem.translate_batch(@stream_items)
    end
  end
end
