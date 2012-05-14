class Api::V1::FeedsController < ActionController::Base
  before_filter :authenticate_user
  respond_to :json

  def show
    @user = User.find_by_display_name(params[:display_name])
    @recent_growls = Growl.order("created_at DESC").limit(3)
  end

  def create
    user = User.where(display_name: params[:display_name]).first
    @growl = user.relation_for(@type).new(params[:body])
    # @growl.build_meta_data(params[:meta_data]) if params[:meta_data]
    if @growl.save 
      render json: @growl, status: 201
    else
      render json: @growl.errors, status: 406
    end
  end

  private

  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    render :json => "Token is invalid.".to_json unless @current_user
  end

  def current_user
    @current_user
  end

end
