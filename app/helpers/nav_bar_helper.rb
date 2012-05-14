module NavBarHelper
  def main_navigation
    if current_user
      {
        "Your Feed" => "http://#{current_user.display_name}.#{request.domain}"
      }
    else
      {

      }
    end
  end

  def home
    if current_user
      "http://#{request.domain}#{dashboard_path}"
    else
      root_path
    end
  end

  def user_helper
    if current_user
      {
        "Sign out" => [destroy_user_session_path, "delete"]
      }
    else
      {
        #"Sign up" => [signup_path, "get"],
        #"Sign in" => [login_path, "get"]
      }
    end
  end

end
