class DashboardsController < ApplicationController
  respond_to :html, :json

  def show
    @image_post = current_user.image_posts.new
    @text_post = current_user.text_posts.new
    @link_post = current_user.link_posts.new
    @posts = current_user.posts.order("created_at DESC").limit(1)
    @posts = @posts.offset((params[:page].to_i-1)*1) if params[:page].present?

    #@posts = @posts.offset(2)
    respond_with @posts
  end
end
