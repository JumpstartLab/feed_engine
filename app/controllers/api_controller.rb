class ApiController < ApplicationController
  before_filter :authenticate_user, only: [:create, :edit, :destroy]
  attr_accessor :current_user

  private

  def authenticate_user
    @current_user = User.find_by_authentication_token(auth_token)
    unless @current_user
      head status: :unauthorized
    end
  end

  def auth_token
    request.env['HTTP_TOKEN']
  end
end
