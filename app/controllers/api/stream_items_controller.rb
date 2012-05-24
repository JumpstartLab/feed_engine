class Api::StreamItemsController < Api::BaseController
  before_filter :verify_auth_token_match, :only => :create
  def show
    @user = User.find_by_display_name(params[:display_name])
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

  def recent
    @user = User.find_by_display_name(params[:display_name])
    @stream_items = @user.stream_items.includes(:user, :streamable).where(:refeed => false).where("id > ?", params[:id].to_i)
  end
end
