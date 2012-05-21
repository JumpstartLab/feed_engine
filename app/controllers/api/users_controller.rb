class Api::UsersController < ApplicationController
  before_filter :validate_api_token

  def index
    
  end

private
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
