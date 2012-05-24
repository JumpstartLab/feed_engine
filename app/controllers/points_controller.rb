class PointsController < ApplicationController
  def create
    if current_user
      post = Post.find(params[:id])
      post.points.create(user_id: current_user.id)
      render :json => true
    else
      post_id = params[:id]
      session[:visitor_post] = post_id
      render :json => {"value"=>"visitor_points"}
    end
  end
end
