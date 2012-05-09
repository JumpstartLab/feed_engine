require 'spec_helper'

describe "Sessions" do
  context "when logging in" do
    context "if valid" do
      let!(:user){ Fabricate(:user) }
      
      it "redirects to root_path" do
        visit new_user_session_path
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button("Sign in")
        page.should have_content("Signed in successfully.") 
      end
    end
  end
end