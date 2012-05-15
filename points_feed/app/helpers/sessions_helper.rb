module SessionsHelper
  def after_sign_in_path_for(user)
    if resource.is_a? User
      user.send_welcome_message()
      twitter_path
    else
      root_path
    end
  end
end