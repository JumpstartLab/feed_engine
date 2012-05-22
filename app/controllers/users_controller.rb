class UsersController < ApplicationController
  respond_to :html, :json

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

end
