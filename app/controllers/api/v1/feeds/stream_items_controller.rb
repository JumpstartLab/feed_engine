class Api::V1::Feeds::StreamItemsController < Api::V1::BaseController
  before_filter :verify_auth_token_match, :only => :create
  def index
    @user = User.find(params[:user_id])
    @stream_items = @user.stream_items.order("created_at DESC").page(params[:page]).per(12)
    @items = StreamItem.translate_batch(@stream_items)
  end

  def show
    user = User.find(params[:user_id])
    @stream_item = user.stream_items.find(params[:id])
    @item = StreamItem.translate_item(@stream_item)
  end

  def create
    @item = @user.new_stream_item_from_json(JSON.parse(params[:body]))
    if @item.save
      @user.add_stream_item(@item)
      respond_with(@item, :status => :created, :location => v1_feeds_user_stream_item_path(@user, @item))
    else
      render :json => {errors: [@item.errors]}, :status => :not_acceptable
      #respond_with(@item.errors, :status => :unprocessable_entity)
    end
  end

  private

  def verify_auth_token_match
    @user = User.find(params[:user_id])
    unless current_user == @user
      render :json => {errors: ["Token does not match specified feed"]},
                      :status => :unauthorized
    end

  end
end
