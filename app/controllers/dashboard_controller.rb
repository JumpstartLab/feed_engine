class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def show
    @posts = Post.all
  end

  def new_post
  end
end
