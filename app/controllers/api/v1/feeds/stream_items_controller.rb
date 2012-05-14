class Api::V1::Feeds::StreamItemsController < Api::V1::BaseController
  def index
    user = User.find(params[:user_id])
    @stream_items = user.stream_items.order("created_at DESC").page(params[:page]).per(12)
    @items = StreamItem.translate_batch(@stream_items)
    respond_with(@items)
  end

  def create
    user = User.find(params[:user_id])
    @item = user.new_stream_item_from_json(JSON.parse(params[:body]))
    if @item.save
      user.add_stream_item(@item)
      respond_with(@item, :status => :created, :location => api_v1_feeds_user_stream_item_path(user, @item))
    else
      render :json => @item.errors, :status => :not_acceptable
      #respond_with(@item.errors, :status => :unprocessable_entity)
    end
  end
end
