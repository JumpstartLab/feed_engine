class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def show
    @posts = current_user.feed.posts.page(params[:page] || 0)
  end
end
