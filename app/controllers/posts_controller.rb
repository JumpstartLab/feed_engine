class PostsController < ApplicationController
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to dashboard_path
    else
      flash.now[:notice] = "There were errors saving your post!"
      render "dashboards/show"
    end
  end
end
