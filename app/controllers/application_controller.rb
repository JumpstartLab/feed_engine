class ApplicationController < ActionController::Base
  include UrlHelper
  protect_from_forgery

  def after_sign_in_path_for(user)
    if resource.is_a? User
      user.send_welcome_message
    end
    dashboard_path
  end
end
