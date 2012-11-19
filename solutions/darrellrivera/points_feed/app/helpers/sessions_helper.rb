module SessionsHelper
  def after_sign_in_path_for(user)
    if user.is_a?(User) && user.sign_in_count < 2
      user.send_welcome_message()
      twitter_path
    else
      root_path
    end
  end
end