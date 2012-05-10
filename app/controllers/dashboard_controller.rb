class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def show
    @posts = current_user.all_posts
  end
end
