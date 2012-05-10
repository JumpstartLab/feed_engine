class DashboardController < ApplicationController
  def show
    @posts = Post.all
  end

  def new_post
  end
end
