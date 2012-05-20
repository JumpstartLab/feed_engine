class ApplicationController < ActionController::Base
  before_filter :set_access_control_headers
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      check_and_add_points unless session[:point_for] == nil
      session[:point_for] = nil
      session[:point_for_type] = nil
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

  def check_and_add_points
    point = Point.create!(user: current_user, pointable_id: session[:point_for], pointable_type: session[:point_for_type])
  end
end
