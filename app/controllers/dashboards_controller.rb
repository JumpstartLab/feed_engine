class DashboardsController < ApplicationController
  def show
    @post = Post.new
  end
end
