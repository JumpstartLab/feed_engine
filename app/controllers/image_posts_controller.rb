class ImagePostsController < ApplicationController
  def new
    @image_post = ImagePost.new
  end

  def create
    @image_post = current_user.image_posts.create(params[:image_post])
    if !@image_post.new_record?
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors posting your image!"
      render :new
    end
  end
end
