require 'spec_helper'

describe "Authentication" do
  context "who is authenticated" do
    it "can sign up from the home page"
    it "cannot sign up with an empty email address"
    it "cannot sign up with an already-used email address"
    it "cannot sign up with an invalid email address"
    it "cannot sign up with an invalid display name"
    it "cannot sign up with an empty password"
    it "cannot sign up with an inconsistent password and confirmation"
    it "cannot sign up with too short of a password"
    it "sends the user an email after a successful sign-up"
  end

  context "who is unauthenticated" do
    let(:new_user) { Fabricate.build(:user) }

    it "can create an account" do
      visit signup_path
      fill_signup_form_for(new_user)
      click_button DOM::SignupForm
      page.should have_content DOM::SignupThankYou
      current_path.should == dashboard_path
      # welcome email should be sent to user.email
    end
  end
end
