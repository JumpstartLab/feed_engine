class LinkPostsController < ApplicationController
  before_filter :lookup_link_post, except: [:create, :new]
  before_filter :require_original_creator, only: [:edit, :update]
  def new
    @link_post = LinkPost.new
  end

  def create
    @link_post = current_user.link_posts.create(params[:link_post])
    if !@link_post.new_record?
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors posting your link!"
      render :new
    end
  end

  def edit
  end

  def update
    @link_post.update_attributes(params[:link_post])
    flash[:notice] = "Successfully Updated"
    redirect_to dashboard_path
  end

  def destroy
    @link_post.destroy
    flash[:notice] = "Successfully Destroyed"
    redirect_to dashboard_path
  end

  private

  def lookup_link_post
    @link_post = LinkPost.find(params[:id])
  end
end
