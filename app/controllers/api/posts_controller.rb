class Api::PostsController < ApiController
  # before_filter :validate_api_token

  def index
    @posts = Post.for_feed(params[:user_display_name])  
  end

  def show
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
