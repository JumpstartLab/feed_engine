class TextPostsController < ApplicationController
  respond_to :html, :json

  def create
    @text_post = TextPost.new(params[:text_post])

    if @text_post.save
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
end
