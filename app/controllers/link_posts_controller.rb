class LinkPostsController < ApplicationController
  def new
    @link_post = LinkPost.new
  end

  def create
    @link_post = LinkPost.create(params[:link_post])
    if !@link_post.new_record?
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors posting your link!"
      render :new
    end
  end
end
