class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :user

  def after_sign_in_path_for(resource_or_scope)
    "/dashboard"
  end

  private

  def user
    @user ||= User.find_by_display_name(request.subdomain)
  end

end
