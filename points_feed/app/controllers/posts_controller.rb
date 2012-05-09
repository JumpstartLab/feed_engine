class PostsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.relation_for(params[:post][:type]).new(params[:post])
    if @post.save
      flash[:notice] = "Your post has been created."
    else
      render :new, :error => "Error saving post."
    end
  end

end
