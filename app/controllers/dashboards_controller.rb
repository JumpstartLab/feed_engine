class DashboardsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  def show
    @image_post = current_user.image_posts.new
    @text_post = current_user.text_posts.new
    @link_post = current_user.link_posts.new
  end
end
