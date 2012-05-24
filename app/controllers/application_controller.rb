#
class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def public?
    true
  end
  helper_method :public?

  def dashboard_posts_private?
    true
  end
  helper_method :dashboard_posts_private?

  def can_refeed?(feed_user, viewing_user)
    if logged_in? && !viewing_user.is_or_is_refeeding?(feed_user)
      true
    else
      false
    end
  end
  helper_method :can_refeed?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Please login to continue."
    end
  end

  def add_point(item_id)
    item = Item.find(item_id)
    item.give_point_from(current_user) if item.poster_id != current_user.id
    session[:point_pending_for] = nil
    session[:return_to] = nil
  end

  def create_user_session
    session[:user_id] = @user.id
  end

  def set_return_session
    session[:return_to] = request.referrer
  end

  def instantiate_posts
    @message = Message.new
    @image = Image.new
    @link = Link.new
  end
  helper_method :instantiate_posts
end
