class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def show
    @posts = Post.for_user(current_user)
  end

  def new_post
  end
end
