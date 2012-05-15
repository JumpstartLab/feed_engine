class Api::PostsController < ApiController
  # before_filter :validate_api_token

  def index
    @user = User.find_by_display_name(params[:user_display_name])
    @posts = @user.posts
  end

  def show
  end

private
  def validate_api_token
    token = params[:access_token] || current_user.api_key
    unless User.exists?(api_key: token)
      render json: {
        :status => :forbidden,
        text: "Access_token not valid or not included."
      }
    end
  end
end
