class Api::FeedsController < Api::ApiController
  before_filter :user

  def show
    respond_with(UserDecorator.decorate(@user))
  end

  def items
    posts = []
    @user.posts.page(params[:page]).per(12).each do |post|
      posts << post.decorate()
    end
    respond_with(posts)
  end

  private

  def user
    @user = User.where(:display_name => params[:id] || params[:feed_id]).first
  end
end
