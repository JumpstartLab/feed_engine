class Api::V1::Feeds::StreamItemsController < Api::V1::BaseController
  before_filter :verify_auth_token_match, :only => :create
  def index
    @user = User.where(:display_name => params[:display_name]).first
    @stream_items = @user.stream_items.order("created_at DESC").page(params[:page]).per(12)
    @items = @stream_items.collect { |i| i.streamable }
  end

  def show
    @user = User.where(:display_name => params[:display_name]).first
    @item = @user.stream_items.find(params[:id]).streamable
  end

  def create
    @item = StreamItem.new_stream_item_from_json(@user.id, JSON.parse(params[:body]))
    if @item.save
      @user.add_stream_item(@item)
      respond_with(@item, :status => :created,
                          :location => v1_feeds_user_stream_item_path(@user, @item))
    else
      render :json => {errors: [@item.errors]}, :status => :not_acceptable
    end
  end

  private

  def verify_auth_token_match
    @user = User.find_by_display_name(params[:display_name])
    unless current_user == @user
      render :json => {errors: ["Token does not match specified feed"]},
                      :status => :unauthorized
    end

  end
end
