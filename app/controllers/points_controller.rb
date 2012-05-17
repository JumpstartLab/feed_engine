class PointsController < ApplicationController
  def update
    @post = Post.find(params[:id])
    @post.update_attribute(:points, @post.add_point)
    redirect_to dashboard_path
  end
end
