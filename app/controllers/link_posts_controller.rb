class LinkPostsController < ApplicationController
  def new
    @link_post = LinkPost.new
  end

  def create
    @link_post = LinkPost.new(params[:link_post])
    if @link_post.save
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:notice] = "There were errors posting your link!"
      render :new
    end
  end
end
