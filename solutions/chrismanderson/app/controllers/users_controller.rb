class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # def edit
  #   @user = User.find(params[:id])
  # end
end
