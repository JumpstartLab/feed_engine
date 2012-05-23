class Api::PostsController < ApiController
  include PostsHelper
  
  def index
    @posts = Feed.find_by_name(params[:feed_name]).posts.collect { |p| p.postable }
  end

  def create
    klass_name = params[:type]
    klass = Module.const_get(klass_name.capitalize)
    parsed_params = params.select do |attribute|
      klass.new.respond_to?(attribute.to_sym) unless attribute.to_sym == :post
    end
    @post = klass.create(parsed_params)
    unless @post.errors.any?
      link_to_poly_post(@post, current_user.feed)
      render "posts/create",
              :status => :created,
              :handlers => [:jbuilder]
    else
      render "posts/create",
              :status => :not_acceptable,
              :handlers => [:jbuilder]
    end
  end

  def refeed
    orig_post = Post.find(params[:post_id])
    current_postables = current_user.feed.posts.collect { |p| p.postable }
    unless orig_post.feed == current_user.feed || 
      current_user.feed.posts.find_by_postable_id_and_postable_type(orig_post.postable_id, orig_post.postable.class.to_s)
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
