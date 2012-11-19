
class TextPostsController < ApplicationController
  before_filter :lookup_text_post, except: [:create, :new]
  before_filter :require_original_creator, only: [:edit, :update]
  respond_to :html, :json

  def create
    @posts = current_user.posts.limit(12)
    @text_post = current_user.text_posts.create(params[:text_post])
    unless @text_post.new_record?
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors saving your post!"
      render :new
    end
  end

  def new
    @text_post = TextPost.new
  end

  def edit
  end

  def update
    @text_post.update_attributes(params[:text_post])
    flash[:notice] = "Successfully Updated"
    redirect_to dashboard_path
  end

  def destroy
    @text_post.destroy
    flash[:notice] = "Successfully Destroyed"
    redirect_to dashboard_path
  end

  private

  def lookup_text_post
    @text_post = TextPost.find(params[:id])
  end
end
