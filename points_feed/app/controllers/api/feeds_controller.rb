class Api::FeedsController < Api::ApiController
  before_filter :can_user_can_view_feed?
  POSTS_PER_PAGE = 12

  def show
    respond_with(UserDecorator.decorate(@user))
  end

  def items
    #posts = user_for_page.posts.page(params[:page]).per(POSTS_PER_PAGE).map(&:decorate)
    offset = compute_offset(params[:page])
    posts = user_for_page.stream(POSTS_PER_PAGE, offset) || []
    posts = posts.map(&:decorate) if posts
    render :json => posts
    #respond_with(posts)
  end

  private

  def compute_offset(page)
    POSTS_PER_PAGE * ((params[:page] || 1).to_i - 1)
  end

  def can_user_can_view_feed?
    error(403) unless user_for_page and user_for_page.can_view_feed?(current_user)
  end

  def user_for_page
    @user ||= User.where("lower(display_name) = ?", params[:id].downcase).first
  end
end
