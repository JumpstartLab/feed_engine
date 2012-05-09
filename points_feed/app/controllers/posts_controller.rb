class PostsController < ApplicationController

def new
  @post = Post.new
end

def create
  @post = Post.class_for(params[:post][:type]).new(params[:post])
  if @post.save
    flash[:notice] = "Your post has been created."
  else
    render :new, :error => "Error saving post."
  end
      

end

end
