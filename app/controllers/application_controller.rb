class ApplicationController < ActionController::Base
  include UrlHelper
  # include SessionsHelper

  protect_from_forgery

  def after_sign_in_path_for(user)
    if resource.is_a? User
      user.send_welcome_message
    end
    dashboard_path
  end

  def after_sign_out_path_for(user)
    (request.protocol +
      request.domain +
      (request.port.nil? ? '' : ":#{request.port}") )
  end
end
