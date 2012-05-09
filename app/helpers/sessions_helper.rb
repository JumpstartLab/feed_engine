module SessionsHelper
  def after_sign_in_path_for(user)
    if resource.is_a? User
      dashboard_path
      # This is separate to allow for different routing
    else
      dashboard_path
    end
  end
end