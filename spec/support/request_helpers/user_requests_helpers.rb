module UserRequestHelpers
  def login_as(user)
    fill_in DOM::LoginEmail, :with => user.email
    fill_in DOM::LoginPassword, :with =>
      Fabricate.attributes_for(:user)[:password]
    click_link_or_button DOM::LoginSubmit
  end

  def signup_as(user)
    fill_in DOM::SignupDisplayName, :with => user.display_name
    fill_in DOM::SignupEmail, :with => user.email
    fill_in DOM::SignupPassword, :with =>
      Fabricate.attributes_for(:user)[:password]
    fill_in DOM::SignupPasswordConfirmation, :with =>
      Fabricate.attributes_for(:user)[:password]
    click_link_or_button DOM::SignupSubmit
  end

  def fill_login_form_as(user)
    fill_in DOM::SignupDisplayName, :with => user.display_name
    fill_in DOM::SignupEmail, :with => user.email
    fill_in DOM::SignupPassword, :with =>
      Fabricate.attributes_for(:user)[:password]
    fill_in DOM::SignupPasswordConfirmation, :with =>
      Fabricate.attributes_for(:user)[:password]
  end

  def fill_signup_form_as(user)
    fill_in DOM::SignupDisplayName, :with => user.display_name
    fill_in DOM::SignupEmail, :with => user.email
    fill_in DOM::SignupPassword, :with =>
      Fabricate.attributes_for(:user)[:password]
    fill_in DOM::SignupPasswordConfirmation, :with =>
      Fabricate.attributes_for(:user)[:password]
  end
end
