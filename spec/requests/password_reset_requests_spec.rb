require 'spec_helper'

describe "Password Reset" do
  let(:user) { Fabricate(:user) }
  before(:each) do
    User.any_instance.stub(:send_password_reset).and_return true
    User.any_instance.stub(:send_welcome_email).and_return true
  end

  context "when a user tries to reset their password" do
    it "they see a forgot password link" do
      visit login_path
      page.should have_link "forgot your password?"
    end

    it "can fill in their email to receive a password reset" do
      visit login_path
      click_link 'forgot your password?'
      fill_in 'Email', :with => user.email
      click_button 'Reset Password'
      page.should have_content "Email sent with password reset instructions."
    end
  end

  context "when a user updates their password" do
    let!(:user) { Fabricate(:user) }
    it "they can view their unique url and create new password" do
      user.create_password_reset
      visit edit_password_reset_path(user.password_reset_token)
      fill_in 'Password', :with => "123abc"
      fill_in 'Password confirmation', :with => "123abc"
      click_button 'Update password'
      page.should have_content "Password has been reset."
      visit login_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "123abc"
      click_button 'Log In'
      page.should have_content "Logged in!"
    end
  end
end