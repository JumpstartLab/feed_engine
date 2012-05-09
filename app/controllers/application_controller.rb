class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    false
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

end