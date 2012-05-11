require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  context "who is authenticated" do
    before(:each) do
      login_as(user)
    end

    describe "and visits the dashboard account tab" do
      before(:each) do
        visit dashboard_path
      end

      it "sees a form to change password" do
        page.should have_field "Password"
        page.should have_field "Password confirmation"
      end

      it "can change their password with valid input" do
        user.password = 'foobar'
        fill_password_change_form_for(user)
        click_button 'Change Password'
        click_link "Log out"
        login_as(user)
        page.should have_content "Logged in!"
        current_path.should == dashboard_path
      end

      it "cannot change their password with invalid input" do
        user.password = '123'
        fill_password_change_form_for(user)
        click_button 'Change Password'
      end
    end
  end

  context "who is unauthenticated" do
    let(:new_user) { Fabricate.build(:user) }

    it "can sign up from the home page" do
      visit root_path
      page.should have_link "Sign Up"
    end

    it "can login using a form on the home page" do
      visit root_path
      page.should have_field "Email"
      page.should have_field "Password"
      fill_login_form_as(user)
      click_button "Log In"
      page.should have_content "Logged in!"
      current_path.should == dashboard_path
    end

    describe "signing up" do
      before(:each) do
        visit signup_path
        fill_signup_form_as(new_user)
      end

      it "sees signup fields on the signup page" do
        page.should have_content "Sign Up"
        page.should have_content "Email"
        page.should have_content "Password"
      end

      describe "when signing up" do
        it "is persisted" do
          expect { click_button "Sign Up" }.to change { User.count }.by(1)
        end

        it "is redirected to their dashboard with a flash message" do
          click_button "Sign Up"
          current_path.should == dashboard_path
          page.should have_content "Thank you for signing up!"
        end

        it "receives an email" do
          expect { click_button "Sign Up" }.to change {
            ActionMailer::Base.deliveries.length
          }.by(1)
        end

        it "doesn't need to re-enter their password if validations fail" do
          fill_in "Display name", :with => 'ABC 123'
          click_button "Sign Up"
          find_field("Password").value.should_not be_blank
        end
      end

      describe "cannot sign up" do
        it "with an empty email address" do
          fill_in "Email", :with => ""
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Email is required"
        end

        it "with an already-used email address" do
          fill_signup_form_as(user)
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Email has already been taken"
        end

        it "with an invalid email address" do
          fill_in "Email", :with => "test"
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Email is invalid"
        end

        it "cannot sign up with a blank display name" do
          fill_in "Display name", :with => ""
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Display name can't be blank"
        end

        it "with an invalid display name" do
          fill_in "Display name", :with => "test test"
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Display name must contain only letters, numbers or dashes"
        end

        it "with an empty password" do
          fill_in "Password", :with => ""
          fill_in "Password confirmation", :with => ""
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Password can't be blank"
        end

        it "with an inconsistent password and confirmation" do
          fill_in "Password", :with => "testering"
          fill_in "Password confirmation", :with => "tester"
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Password doesn't match confirmation"
        end

        it "with too short of a password" do
          fill_in "Password", :with => "testr"
          fill_in "Password confirmation", :with => "testr"
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Password is too short"
        end
      end
    end
  end
end
