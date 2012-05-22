require 'spec_helper'

describe "Registration" do
  context "when I am a logged in user" do
    let (:user) { Fabricate(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "Sign in"
    end

    context "and when I am on the dashboard page" do
      before(:each) do
        visit dashboard_path
      end

      it "allows me to update my password" do
        click_link "Edit Account"
        fill_in "user_current_password", :with => user.password
        fill_in "user_password", :with => "hungry"
        fill_in "user_password_confirmation", :with => "hungry"
        click_button "Update"
        page.should have_content("You updated your account successfully.")
      end
    end
  end  
end