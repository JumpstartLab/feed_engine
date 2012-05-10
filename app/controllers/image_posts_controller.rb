class ImagePostsController < ApplicationController
  def new
    @image_post = ImagePost.new
  end

  def create
    @image_post = ImagePost.new(params[:image_post])
    raise @image_post.inspect
    if @image_post.save
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:notice] = "There were errors posting your image!"
      render :new
    end
  end

  def show
    @image_post = ImagePost.find(params[:id])
  end
end
