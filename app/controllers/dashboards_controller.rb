class DashboardsController < ApplicationController
  respond_to :html, :json

  def show
    # @image_post = current_user.image_posts.new
    @post = current_user.text_posts.new
    @posts = Post.limit(10)
    respond_with @posts
  end
end
