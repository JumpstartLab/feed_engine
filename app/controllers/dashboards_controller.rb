class DashboardsController < ApplicationController
  respond_to :html, :json

  def show
    @image_post = ImagePost.new
    @post = TextPost.new
    @posts = ImagePost.order_stream
    respond_with @posts
  end
end
