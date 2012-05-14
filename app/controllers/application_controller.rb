class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :validate_api_token

  private

  def load_user
    @user = User.find_by_subdomain!(request.subdomain)
  end

  def validate_api_token
    token = params[:access_token] || current_user.api_key
    unless User.exists?(api_key: token)
      render json: {
        :status => :forbidden,
        text: "Access_token not valid or not included."
      }
    end
  end
end
