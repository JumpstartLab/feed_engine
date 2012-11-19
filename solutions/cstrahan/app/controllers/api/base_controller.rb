class Api::BaseController < ActionController::Base
  before_filter :authenticate_user
  respond_to :xml, :json

  private

  def master_token
    "d85a867e21cc571242e10ef62bc07ef9"
  end

  def require_master_token
    unless params[:token] == master_token
      respond_with do |format|
        error = {error: "Invalid master token."}
        format.json { render json: error, status: 401 }
        format.xml  { render xml:  error, status: 401 }
      end
    end
  end

  def current_user
    @current_user
  end

  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      respond_with do |format|
        error = {error: "Token not found."}
        format.json { render json: error, status: 401 }
        format.xml  { render xml:  error, status: 401 }
      end
    end
  end
end
