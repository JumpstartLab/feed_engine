class ApiController < ApplicationController
  before_filter :authenticate

  attr_accessor :current_user

  private

  def authenticate
    @current_user = User.find_by_authentication_token(params[:token])
    unless @current_user
      respond_with({:error => "Token is invalid." })
    end
  end
end
