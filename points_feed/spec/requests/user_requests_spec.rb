require 'spec_helper'

describe User do
  context "when I am not logged in" do
    context "and when I visit the signup path" do
      before(:each) do
        visit signup_path
      end
      it "has the signup form" do
        page.should have_content("Sign up")
      end

      context "and when I fill out information properly" do
        it "should show confirmation message" do
          fill_in "Email", :with => "foo@bar.com"
          fill_in "Display name", :with => "displayname"
          fill_in "Password", :with => "hungry"
          fill_in "Password confirmation", :with => "hungry"
          click_button "Sign Up"
          page.should have_content("Welcome! You have signed up successfully.")
        end

        it "should redirect me to dashboard"

        it "should send welcome email to user"
      end

      context "and when I fill out the information improperly" do
        it "should show an error message for improper email format" do
          fill_in "Email", :with => "foo@"
          fill_in "Display name", :with => "displayname"
          fill_in "Password", :with => "hungry"
          fill_in "Password confirmation", :with => "hungry"
          click_button "Sign Up"
          page.should have_content("is invalid")
        end

        it "should show an error message for a blank email" do
          fill_in "Email", :with => ""
          fill_in "Display name", :with => "displayname"
          fill_in "Password", :with => "hungry"
          fill_in "Password confirmation", :with => "hungry"
          click_button "Sign Up"
          page.should have_content("can't be blank")
        end

        it "should show an error message for improper display name" do
          pending
          fill_in "Email", :with => "foo@bar.com"
          fill_in "Display name", :with => "display name"
          fill_in "Password", :with => "hungry"
          fill_in "Password confirmation", :with => "hungry"
          click_button "Sign Up"
          page.should have_content("can't be blank")
        end   

        it "should show an error message for a blank display name" do
          fill_in "Email", :with => "foo@bar.com"
          fill_in "Display name", :with => ""
          fill_in "Password", :with => "hungry"
          fill_in "Password confirmation", :with => "hungry"
          click_button "Sign Up"
          page.should have_content("can't be blank")
        end 

        it "should show an error message for a blank password" do
          fill_in "Email", :with => "foo@bar.com"
          fill_in "Display name", :with => "displayname"
          fill_in "Password", :with => ""
          fill_in "Password confirmation", :with => "hungry"
          click_button "Sign Up"
          page.should have_content("can't be blank")
        end  

        it "should show an error message for a password less than 6 characters" do
          fill_in "Email", :with => "foo@bar.com"
          fill_in "Display name", :with => "displayname"
          fill_in "Password", :with => "12345"
          fill_in "Password confirmation", :with => "12345"
          click_button "Sign Up"
          page.should have_content("is too short (minimum is 6 characters)")
        end   

        it "should show an error message for not matching passwords" do
          fill_in "Email", :with => "foo@bar.com"
          fill_in "Display name", :with => "displayname"
          fill_in "Password", :with => "123456"
          fill_in "Password confirmation", :with => "1234567"
          click_button "Sign Up"
          page.should have_content("doesn't match confirmation")
        end          
      end

      context "and I sign in with an existing email" do
        let!(:user) { Fabricate(:user) }

        it "should show error message for existing" do
          fill_in "Email", :with => user.email
          fill_in "Display name", :with => user.display_name
          fill_in "Password", :with => user.password
          fill_in "Password confirmation", :with => user.password
          click_button "Sign Up"
          page.should have_content("has already been taken")
          page.should have_content("Sign up")
          find_field('Display name').value.should == user.display_name
        end


      end
    end  
  end
end