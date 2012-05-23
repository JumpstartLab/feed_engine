class Api::StreamItemsController < Api::BaseController
  before_filter :verify_auth_token_match, :only => :create
  def show
    @user = User.where(:display_name => params[:display_name]).first
    @stream_item = @user.stream_items.find(params[:id])
    @item = @stream_item.streamable
  end

  def create
    @item = StreamItem.new_stream_item_from_json(@user.id, JSON.parse(params[:body]))
    if @item.save
      respond_with(@item, :status => :created,
                          :location => api_item_path(@user, @item))
    else
      render :json => {errors: [@item.errors]}, :status => :not_acceptable
    end
  end
end
