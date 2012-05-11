class TextPostsController < ApplicationController
  respond_to :html, :json

  def create
    @posts = current_user.posts.limit(12)
    @post = current_user.text_posts.create(params[:text_post])
    if !@post.new_record?
      flash[:notice] = "Your message was saved!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There were errors saving your post!"
      render "dashboards/show"
    end
  end
end
