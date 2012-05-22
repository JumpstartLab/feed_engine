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
    @posts = Post.all.collect {|post| post.postable}.reverse.page(params[:page].to_i || 0)
  end

  def show
    user = User.find_by_display_name(params[:display_name])
    temp_posts = user.feed.posts.reverse.page(params[:page].to_i || 0)
    @posts = temp_posts
    render action: :index
  end

  def ind
    user = User.find_by_subdomain(request.subdomain)
    if (current_user && user && current_user == user) || (user.nil? &&  current_user)     
      user = current_user     
    end
    params[:page] = "0" if params[:page] && params[:page] == "NaN" 
    temp_posts = user.feed.posts.reverse.page(params[:page].to_i || 0)
    @posts = temp_posts.collect { |p| p.postable }
    render "posts/index"
  end

  def refeed
    orig_post = Post.find(params[:post_id])
    unless orig_post.feed == current_user.feed    
      cloned_post = current_user.feed.posts.create
      cloned_post.postable = orig_post.postable
    end
    if cloned_post && cloned_post.save
      head :status => :created
    else
      head :status => :not_acceptable
    end
  end
end
