class Api::StreamItemsApiController < ApplicationController
  def index
    @stream_items = User.first.stream_items.order("created_at DESC").page(params[:page]).per(12)
    @items = StreamItem.translate_batch(@stream_items)

    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end
end
