include Warden::Test::Helpers

module ControllerMacros
  # VoodooDoubleLogin(tm)
  # login(user) is a devise helper to convince devise u are logged in
  # login_factory_user makes a post to sessions controller
  # in order to keep you logged in across subdomains
  # no one knows.
  def login_user(email, password)
    page.driver.post(user_session_url, :user => { email: email, password: password})
  end

  def login_factory_user(email)
    login_user(email, "password")
  end

  def login(user)
    login_as user, scope: :user
  end

  def create_logged_in_user
    user = FactoryGirl.create(:user)
    login(user)
    user
  end
end
