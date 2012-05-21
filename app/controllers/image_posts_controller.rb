class ImagePostsController < ApplicationController
  before_filter :lookup_image_post, except: [:new, :create]
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

  def show
  end

  def edit
  end

  def update
    @image_post.update_attributes(params[:image_post])
    flash[:notice] = "Successfully Updated"
    redirect_to dashboard_path
  end

  def destroy
    @image_post.destroy
    flash[:notice] = "Successfully Destroyed"
    redirect_to dashboard_path
  end

  private

  def lookup_image_post
    post = Post.find(params[:id])
    child_post = post.postable
    @image_post = ImagePost.find(child_post.id)
  end
end
