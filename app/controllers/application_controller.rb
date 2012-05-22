class ApplicationController < ActionController::Base
  include UrlHelper
  # include SessionsHelper
  protect_from_forgery

  def after_sign_in_path_for(user)
    increment_points if session[:growl_needing_point]
    if resource.is_a? User
      user.send_welcome_message
      new_authentication_path
    else
      dashboard_path
    end
  end

  def after_sign_out_path_for(user)
    (request.protocol +
      request.domain +
      (request.port.nil? ? '' : ":#{request.port}") )
  end

  def increment_points
    growl = Growl.find(session[:growl_needing_point])
    growl.increment!(:points)
    session[:growl_needing_point] = nil
  end

end
