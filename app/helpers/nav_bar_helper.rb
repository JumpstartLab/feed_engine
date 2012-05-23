module NavBarHelper
  def main_navigation
    if current_user
      {
        "Feed" => "http://#{current_user.display_name}.#{request.domain}",
        "Account" => edit_user_registration_path
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
        "Sign in" => [login_path, "get"]
      }
    end
  end

end
