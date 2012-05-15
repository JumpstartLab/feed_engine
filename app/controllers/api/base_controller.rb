class Api::BaseController < ActionController::Base
  before_filter :authenticate_user
  respond_to :xml, :json

  private

  def current_user
    @current_user
  end

  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      respond_with do |format|
        error = {error: "Token not found."}
        format.json { render json: error }
        format.xml  { render xml:  error }
      end
    end
  end
end
