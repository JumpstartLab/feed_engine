require 'spec_helper'

describe User do
  context "when I am not logged in" do
    context "and when I visit the signup path" do
      before(:each) do
        visit new_user_registration_path
        fill_in "user[email]", :with => "foo@bar.com"
        fill_in "user[display_name]", :with => "displayname"
        fill_in "user[password]", :with => "hungry"
        fill_in "user[password_confirmation]", :with => "hungry"
      end

      it "has the signup form" do
        page.should have_content("Sign up")
      end

      context "and when I fill out information properly" do
        it "should show confirmation message" do
          click_button "Create An Account"
          page.should have_content("Welcome! You have signed up successfully.")
        end

        it "should redirect me to dashboard" do
          click_button "Create An Account"
          page.should have_content("Dashboard")
        end

        it "should send welcome email to user" do
          click_button "Create An Account"
          invite_email = ActionMailer::Base.deliveries.last
          invite_email.subject.should == "Welcome to PointsFeed!"
        end
      end

      context "and when I fill out the information improperly" do
        it "should show an error message for improper email format" do
          fill_in "user[email]", :with => "foo@"
          click_button "Create An Account"
          page.should have_content("must be in the form")
        end

        it "should show an error message for a blank email" do
          fill_in "user[email]", :with => ""
          click_button "Create An Account"
          page.should have_content("can't be blank")
        end

        it "should show an error message for improper display name" do
          fill_in "user[display_name]", :with => "display name"
          click_button "Create An Account"
          page.should have_content("Must only be letters, numbers, underscore or dashes")
        end   

        it "should show an error message for a blank display name" do
          fill_in "user[display_name]", :with => ""
          click_button "Create An Account"
          page.should have_content("can't be blank")
        end 

        it "should show an error message for a blank password" do
          fill_in "user[password]", :with => ""
          click_button "Create An Account"
          page.should have_content("can't be blank")
        end  

        it "should show an error message for a password less than 6 characters" do
          fill_in "user[password]", :with => "12345"
          fill_in "user[password_confirmation]", :with => "12345"
          click_button "Create An Account"
          page.should have_content("is too short (minimum is 6 characters)")
        end   

        it "should show an error message for not matching passwords" do
          fill_in "user[password]", :with => "123456"
          fill_in "user[password_confirmation]", :with => "1234567"
          click_button "Create An Account"
          page.should have_content("doesn't match confirmation")
        end          
      end

      context "and I sign in with an existing email" do
        let!(:user) { Fabricate(:user) }

        it "should show error message for existing" do
          fill_in "user[email]", :with => user.email
          fill_in "user[display_name]", :with => user.display_name
          fill_in "user[password]", :with => user.password
          fill_in "user[password_confirmation]", :with => user.password
          click_button "Create An Account"
          page.should have_content("has already been taken")
          page.should have_content("Sign up")
          find_field('user[display_name]').value.should == user.display_name
        end
      end
    end  
  end
end