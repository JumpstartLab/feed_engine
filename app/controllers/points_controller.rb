class PointsController < ApplicationController
  def update
    child = params[:post_type].constantize.find(params[:id])
    @post = child.post
    @post.update_attribute(:points, @post.add_point)
    redirect_to user_path(@post.user.id)
  end
end
