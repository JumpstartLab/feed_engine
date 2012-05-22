class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :user

  def after_sign_in_path_for(resource_or_scope)
    if resource.is_a?(User)
      user.send_welcome_email
      authentication_path(resource_or_scope)
    else
      super
    end
  end

  def after_update_path_for(resource_or_scope)
    flash[:notice] = "Account updated!"
    "/dashboard"
  end

  private

  def user
    @user ||= User.where("lower(display_name) = lower(?)", params[:user_display_name] || request.subdomain).first
  end

end
