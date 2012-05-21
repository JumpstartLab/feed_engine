class Api::V1::ApiController < ActionController::Base
  before_filter :authenticate_user_token
  respond_to :json

  def validate_token
    render :json => "Token is VALID", status: 200
  end

  private

  def authenticate_user_token
    @current_user = User.find_by_authentication_token(auth_token)
    unless @current_user
      render :json => "Token is invalid.", status: :unauthorized
    end
  end

  def auth_token
    if Rails.env.development? || Rails.env.test?
      request.env['HTTP_AUTH_TOKEN'] || params[:token]
    else
      request.env['X-HTTP-AUTHTOKEN'] || params[:token]
    end
  end
end