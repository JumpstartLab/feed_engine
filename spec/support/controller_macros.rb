module ControllerMacros
  def login_user(email, password)
    page.driver.post(user_session_url, :user => { email: email, password: password}) 
  end

  def login_factory_user(email)
    login_user(email, "password")
  end
end
