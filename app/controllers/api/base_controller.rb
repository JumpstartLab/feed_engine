class Api::BaseController < ApplicationController
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

  def verify_auth_token_match
    @user = User.where("display_name LIKE ?", params[:display_name]).first
    unless current_user == @user
      render :json => {errors: ["Token does not match specified feed"]},
                      :status => :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
