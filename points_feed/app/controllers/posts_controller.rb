class PostsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def create
    @post = current_user.relation_for(params[:post][:type]).new(params[:post])
    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to dashboard_path
    else
      @posts = current_user.posts.last(5)
      @post = @post.becomes(Post)
      render "dashboards/show"
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
