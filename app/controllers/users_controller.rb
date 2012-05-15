class UsersController < ApplicationController
  respond_to :html, :json

  def show
    @posts = user.posts.order("created_at DESC").limit(7)
    @posts = @posts.offset((params[:page].to_i-1)*7) if params[:page].present?
    respond_with @posts
  end

  def edit
    @user = current_user
  end
end
