require 'spec_helper'

describe "Sessions" do
  context "when logging in" do
    context "if valid" do
      let!(:user){ Fabricate(:user) }
    
      it "redirects to root_path" do
        visit new_user_session_path
        fill_in "user_email", :with => user.email
        fill_in "user_password", :with => user.password
        click_button("Sign in")
        page.should have_content("Sign Out") 
      end
    end
  end
end
