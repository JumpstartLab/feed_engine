class ApplicationController < ActionController::Base
  before_filter :set_access_control_headers
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      "/dashboard"
    else
      super
    end
  end

  helper_method :resource, :resource_name

  def resource
    current_user
  end

  def resource_name
    "user"
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end
