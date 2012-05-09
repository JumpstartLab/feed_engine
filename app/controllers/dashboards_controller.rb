class DashboardsController < ApplicationController
  def show
    @post = Post.new
    @image_post = ImagePost.new
  end
end
