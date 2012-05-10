class PostsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.relation_for(params[:post][:type]).new(params[:post])
    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to dashboard_path
    else
      #TODO: There must be a way to redirect or render to multiple pages
      #      without having to redefine variables that are set in the 
      #      controller *and* without losing the ones that are set in this
      #      one. 
      flash[:error] = @post.errors.full_messages.join(', ')
      @posts = current_user.posts.last(5)
      render "dashboards/show"
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
