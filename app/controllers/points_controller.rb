class PointsController < ApplicationController
  def create
    post_id = params[:post_id]
    user_id = params[:user_id]
    post = Post.find(post_id)
    @point = Point.create(post_id: post_id, user_id: user_id)
    if @point.save
      flash[:notice] = "Point Added!"
      redirect_to :back
    else
      flash[:notice] = "You can only point once!"
      redirect_to :back
    end
  end
end
