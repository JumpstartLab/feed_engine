module UserRequestHelpers
  def login_as(user)
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with =>
      Fabricate.attributes_for(:user)[:password]
    click_link_or_button "Log In"
  end

  def signup_as(user)
    fill_in "Display name", :with => user.display_name
    fill_in "Email", :with => user.email
    fill_in "Password", :with =>
      Fabricate.attributes_for(:user)[:password]
    fill_in "Password confirmation", :with =>
      Fabricate.attributes_for(:user)[:password]
    click_link_or_button "Sign Up"
  end

  def fill_login_form_as(user)
    fill_in "Email", :with => user.email
    fill_in "Password", :with =>
      Fabricate.attributes_for(:user)[:password]
  end

  def fill_signup_form_as(user)
    fill_in "Display name", :with => user.display_name
    fill_in "Email", :with => user.email
    fill_in "Password", :with =>
      Fabricate.attributes_for(:user)[:password]
    fill_in "Password confirmation", :with =>
      Fabricate.attributes_for(:user)[:password]
  end

  def fill_password_change_form_for(user)
    fill_in "Password", :with =>
      Fabricate.attributes_for(:user)[:password]
    fill_in "Password confirmation", :with =>
      Fabricate.attributes_for(:user)[:password]
  end

  def logout
    visit logout_path
  end
end
