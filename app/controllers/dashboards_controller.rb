class DashboardsController < ApplicationController
  def show
    @post = TextPost.new
    @image_posts = ImagePost.all
  end
end
