class HomeController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(12)
  end
end
