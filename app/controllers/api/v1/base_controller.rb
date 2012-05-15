class Api::V1::BaseController < ApplicationController
  respond_to :json

  before_filter :authenticate_user

private
  def authenticate_user
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      error = { :error => "Token is invalid." }
      respond_with(error) do |format|
        format.json { render :json => error }
      end
    end
  end

  def current_user
    @current_user
  end
end
