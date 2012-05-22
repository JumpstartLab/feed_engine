  class PostsController < ApplicationController
  include PostsHelper

  def create
    klass_name = params[:type]
    klass = Module.const_get(klass_name.capitalize)
    @post = klass.create(params[klass_name.downcase])
    unless @post.errors.any?
      link_to_poly_post(@post, current_user.feed)
      render "create",
              :status => :ok,
              :handlers => [:jbuilder]
    else
      render "create",
              :status => :unprocessable_entity,
              :handlers => [:jbuilder]
    end
  end

  def index
    @posts = Post.all.collect {|post| post.postable}.page(params[:page] || 0)
    render "pages/index"
  end

  def show
    user = User.find_by_display_name(params[:display_name])
    temp_posts = user.feed.posts.reverse.page(params[:page].to_i || 0)
  end
end
