class PagesController < ApplicationController
  def index
    @users = User.all
  end

  def footer
    render layout: false
  end

  def signin
    render "users/sessions/new", layout: false
  end

  def signup
    render "users/new", layout: false
  end

  def home
    @posts = Posts.all.collect {|post| post.postable}.page(params[:page])
    if @users.empty?
      render "404.html", layout: false
    end

    render layout: false
  end

  def friends
    
  end

  def dashboard
    
  end

end
