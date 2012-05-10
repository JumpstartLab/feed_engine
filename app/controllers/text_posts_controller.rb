class TextPostsController < ApplicationController
  def create
    @post = TextPost.new(params[:text_post])
    if @post.save
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors saving your post!"
      render "dashboards/show"
    end
  end
end
