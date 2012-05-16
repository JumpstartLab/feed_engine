class UsersController < ApplicationController
  respond_to :html, :json

  def show
    @posts = user.posts.page(params[:page])
    respond_with @posts
  end

  def edit
    @user = current_user
  end

end
