class Api::FeedsController < Api::ApiController
  before_filter :view_feed!

  def show
    respond_with(UserDecorator.decorate(@user))
  end

  def items
    posts = @user.posts.page(params[:page]).per(12).map do |post| 
      post.decorate()
    end

    render :json => posts
    #respond_with(posts)
  end

  private

  def view_feed!
    authenticate_user
    @user = User.where(:display_name => params[:id]).first
    error(403) unless @user and @user.can_view_feed?(@current_user)
  end
end
