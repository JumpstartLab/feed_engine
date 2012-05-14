module SessionsHelper
  def after_sign_in_path_for(user)
    if resource.is_a? User
      user.send_welcome_message()
      dashboard_path
    else
      root_path
    end
  end

  def after_update_path_for(resource)
    dashboard_path
  end
end