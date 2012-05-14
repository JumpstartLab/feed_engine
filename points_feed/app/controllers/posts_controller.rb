class PostsController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def show
    @post = Post.find(params[:id])
  end
end
