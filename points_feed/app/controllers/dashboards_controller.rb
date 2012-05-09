class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @posts = current_user.posts.last(5)
  end

end
