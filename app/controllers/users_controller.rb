class UsersController < ApplicationController
  respond_to :html, :json

  def show
  end

  def edit
    @user = current_user
  end

  def following
  end

  def followers
  end

  def refeeds
  end

end
