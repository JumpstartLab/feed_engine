class ApplicationController < ActionController::Base
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
end
