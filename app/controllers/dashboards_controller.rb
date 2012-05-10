class DashboardsController < ApplicationController
  respond_to :html, :json

  def show
    @image_post = ImagePost.new
    @post = TextPost.new
    page_number = params[:page].to_i
    posts_per_page = 12
    offset = posts_per_page * page_number
    @posts = User.order_stream[offset..(offset+posts_per_page-1)]
    respond_with @posts
  end
end
