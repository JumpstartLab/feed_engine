class DashboardsController < ApplicationController
  def show
    @text_post = TextPost.new
    @image_post = ImagePost.new
    @link_post = LinkPost.new

    # @image_post = ImagePost.last
    # @text_post = TextPost.last
    # @link_post = LinkPost.last
  end
end
