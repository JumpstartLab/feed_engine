class DashboardsController < ApplicationController
  def show
    @image_post = ImagePost.new
    @post = TextPost.new
  end
end
