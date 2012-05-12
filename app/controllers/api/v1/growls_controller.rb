class Api::V1::ImagesController < ActionController::Base
  #before_filter :authenticate_user!
  respond_to :json
  def index
    display_name = params[:display_name]
    user = User.where(display_name: display_name)
    respond_with(user.growls)
  end
end