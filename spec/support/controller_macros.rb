include Warden::Test::Helpers

module ControllerMacros
  def login_user(email, password)
    page.driver.post(user_session_url, :user => { email: email, password: password})
  end

  def login_factory_user(email)
    login_user(email, "password")
  end

  def create_logged_in_user
    user = Factory(:user)
    login(user)
    user
  end
 
  def login(user)
    login_as user, scope: :user
  end
end
