class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def show
    @posts = current_user.posts
  end

  def new_post
  end
end
