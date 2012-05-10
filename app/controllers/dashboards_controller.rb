class DashboardsController < ApplicationController
  respond_to :html, :json

  def show
    @text_post = TextPost.new
    @image_post = ImagePost.new
    @link_post = LinkPost.new

    page_number = params[:page].to_i
    posts_per_page = 12
    offset = posts_per_page * page_number
    @posts = User.order_stream[offset..(offset+posts_per_page-1)]

    respond_with @posts
  end
end
