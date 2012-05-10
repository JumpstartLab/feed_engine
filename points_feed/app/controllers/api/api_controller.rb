class Api::ApiController < ActionController::Base
  respond_to :json, :xml
  before_filter :authenticate_token!

  def authenticate_token!
    if request.post?
      auth_token = params[:auth_token]
      user = User.where(:authentication_token => auth_token).first

      if user.blank?
        raise "Need authentication token"
      end
    end
  end
end