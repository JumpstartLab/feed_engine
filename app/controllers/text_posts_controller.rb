class TextPostsController < ApplicationController
  respond_to :html, :json

  def create
    @posts = User.order_stream[0..4]
    @post = TextPost.new(params[:text_post])
    if @post.save
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors saving your post!"
      render "dashboards/show"
    end
  end

  def new
    @text_post = TextPost.new
  end
end
