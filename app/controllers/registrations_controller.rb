class RegistrationsController < Devise::RegistrationsController

  def after_sign_in_path_for(user)
    if resource.is_a? User
      user.send_welcome_email
      authentication_path(user)
    else
      dashboard_path
    end
  end

end
