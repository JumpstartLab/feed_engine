class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @post = current_user.posts.new
  end

end
