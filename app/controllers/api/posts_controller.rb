class Api::PostsController < ApiController
  # before_filter :validate_api_token

  def index
    @posts = Post.for_feed(params[:feed_name])  
  end

  def create
    klass_name = params[:type]
    params[klass_name][:user_id] = current_user.id
    klass = Module.const_get(klass_name.capitalize)
    @post = klass.create(params[klass_name.downcase])
    unless @post.errors.any?
      render "create",
              :status => :ok,
              :handlers => [:jbuilder]
    else
      render "create",
              :status => :unprocessable_entity,
              :handlers => [:jbuilder]
    end
  end

private
  def validate_api_token
    token = params[:access_token] || current_user.api_key
    unless User.exists?(api_key: token)
      render json: {
        :status => :unauthorized,
        text: "Access_token not valid or not included."
      }
    end
  end
end
