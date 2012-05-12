class Api::V1::FeedsController < ActionController::Base
  respond_to :json

  def show
    user = User.find_by_display_name(params[:id])
    if user
      respond_with(user.growls)
    end
  end
end
