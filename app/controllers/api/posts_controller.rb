class Api::PostsController < ApiController
  def index
    @posts = Post.for_feed(params[:feed_name])
  end

  def create
    klass_name = params[:post][:type]
    params[:post][:user_id] = current_user.id
    klass = Module.const_get(klass_name.capitalize)
    parsed_params = params[:post].select do |attribute|
      klass.new.respond_to?(attribute.to_sym)
    end
    @post = klass.create(parsed_params)
    unless @post.errors.any?
      render "posts/create",
              :status => :ok,
              :handlers => [:jbuilder]
    else
      render "posts/create",
              :status => :unprocessable_entity,
              :handlers => [:jbuilder]
    end
  end
end
