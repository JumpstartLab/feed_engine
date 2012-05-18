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
    Item.give_point_to(item_id) if item.poster_id != current_user.id
    session[:point_pending_for] = nil
    session[:return_to] = nil
  end
end
