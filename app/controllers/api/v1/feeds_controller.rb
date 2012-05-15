class Api::V1::FeedsController < ActionController::Base
  before_filter :authenticate_user
  respond_to :json

  def show
    @user = User.find_by_display_name(params[:display_name])
    @recent_growls = Growl.order("created_at DESC").limit(3)
  end

  def create
    json_hash = JSON.parse(params[:body])
    @growl = current_user.relation_for(json_hash["type"]).new(json_hash)
    @growl.build_meta_data(params[:meta_data]) if params[:meta_data]
  
    if @growl.save
      render location: @growl, status: :created
    else
      @errors = @growl.errors.collect { |k,v| v }
      render 'create', status: :not_acceptable
    end
  end

  private

  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      render :json => "Token is invalid.".to_json, status: 401
    end
  end

  def current_user
    @current_user
  end

end
