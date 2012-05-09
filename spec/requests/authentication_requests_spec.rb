require 'spec_helper'

describe "Authentication" do
  before(:each) do
    visit root_path
  end
  context "when not logged in" do
    it "can sign up from the home page" do
      pending
      # can be changed for proper route
      current_path.should == new_user_path
      page.should have_content "Sign Up"
    end
    it "cannot sign up with an empty email address" do
      pending
      click_link_or_button "Sign Up"
      signup(password: "test", display_name: "test")
      current_path.should == root_path
      page.should have_content "email address"
      page.should have_content "blank"
    end
    it "cannot sign up with an already-used email address"
    it "cannot sign up with an invalid email address"
    it "cannot sign up with an invalid display name"
    it "cannot sign up with an empty password"
    it "cannot sign up with an inconsistent password and confirmation"
    it "cannot sign up with too short of a password"
    it "sends the user an email after a successful sign-up"
  end
  context "when already have an account" do
    context "when not logged in" do
      it "can sign in from the home page" do
        pending
        visit root_path
        # can be changed for proper route
        current_path.should == new_user_path
        page.should have_content "Sign In"
      end
      it "takes the user to the dashboard after signing in"
    end
  end
  context "after signing in"
end
