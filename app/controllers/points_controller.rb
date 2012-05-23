class PointsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    post.points.create(user_id: current_user.id)
    render :json => true
  end
end
