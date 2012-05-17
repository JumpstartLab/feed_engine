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
end
