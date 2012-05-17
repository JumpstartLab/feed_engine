class Api::FeedsController < Api::ApiController
  before_filter :can_user_can_view_feed?, :except => :index
  POSTS_PER_PAGE = 12

  def index
    posts = Post.page(params[:page]).per(12).map { |post| post.decorate }
    render :json => posts
  end

  def show
    respond_with(UserDecorator.decorate(@user))
  end

  def items
    #posts = user_for_page.posts.page(params[:page]).per(POSTS_PER_PAGE).map(&:decorate)
    offset = compute_offset(params[:page])
    posts = user_for_page.stream(POSTS_PER_PAGE, offset) || []
    posts = posts.map(&:decorate) if posts
    posts = posts.map { |post| post.current_user = current_user; post }

    render :json => posts
    #respond_with(posts)
  end

  def refeed
    source_feed_item = user_for_page.posts.find_by_id(params[:item_id].to_i)
    unless current_user && current_user == user_for_page
      source_feed_item.refeed(current_user)
      head :status => 201
    else
      error(403)
    end
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
