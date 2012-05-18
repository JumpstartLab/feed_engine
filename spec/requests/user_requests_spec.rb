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

    context "and navigating the site from the header" do

      it "has the app name with a link to the aggregate feed" do
        within ".navbar" do
          page.should have_link "SuperHotFeedEngine"
          click_link_or_button "SuperHotFeedEngine"
        end
        current_path.should == root_path(subdomain: false)
      end

      it "links to log out" do
        within ".navbar" do
          page.should have_link "Log out"
          click_link_or_button "Log out"
        end
        page.should have_content "Logged out"
        current_path.should == root_path
      end

      it "links to the current user's feed" do
        within ".navbar" do
          page.should have_link "#{user.display_name}'s Feed"
          click_link_or_button "#{user.display_name}'s Feed"
        end
        within "#main-content" do
          page.should have_content "#{user.display_name}'s feed"
        end
      end

      it "links to the current user's dashboard" do
        click_link_or_button "Dashboard"
        current_path.should == dashboard_path
        click_link_or_button "#{user.display_name}'s Feed"
        click_link_or_button "Dashboard"
        current_path.should == dashboard_path
      end

    end
    context "adds points" do
      let!(:other_user) { Fabricate(:user) }
      let(:random_post_type) { ["message", "link", "github_event", "tweet", "image"].sample }
      it "add points to a post" do
        random_post = Fabricate(random_post_type.to_sym, poster_id: other_user.id)
        set_host(other_user.subdomain)
        visit root_path
        page.should have_content "Points!"
        click_link_or_button "Points! (#{random_post.points})"
        updated_post = random_post.class.find(random_post.id)
        updated_post.points.should == 1
        current_path.should == root_path
        within "#points" do
          page.should have_content updated_post.points
        end
      end
      it "cannot give it's own post points" do
        random_post = Fabricate(random_post_type.to_sym, poster_id: user.id)
        set_host(user.subdomain)
        visit root_path
        page.should have_content "Points!"
        page.should_not have_link "Points! (#{random_post.points})"
      end

    end

  end

  context "who is unauthenticated" do
    let(:new_user) { Fabricate.build(:user) }

    it "can sign up from the home page via top nav" do
      visit root_path
      page.should have_link "Sign up"
    end

    it "can see the aggregated posts" do
      visit root_path
      page.should have_content "All Posts"
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

        it "with an already used display name" do
          user.email = "test@test.com"
          fill_signup_form_as(user)
          expect { click_button "Sign Up" }.to change { User.count }.by(0)
          page.should have_content "Display name has already been taken"
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

      context "after signing up" do
        it "sees a page with an option to authorize twitter" do
          click_button "Sign Up"
          page.should have_content "Connect with Twitter"
        end
        it "sees that it is connected with twitter after connecting" do
          click_button "Sign Up"
          last_user = User.last
          Fabricate(:subscription, user_id: last_user.id, provider: "twitter")
          visit new_subscription_path
          page.should have_content last_user.subscription("twitter").user_name
        end
        it "can authorize twitter" do
          pending
          click_button "Sign Up"
          click_link_or_button "Connect with Twitter"
          page.should have_content "Twitter account has been linked"
        end
        it "sees a page with an option to authorize github" do
          click_button "Sign Up"
          page.should have_content "Connect with Github"
        end
        it "sees that it is connected with github after connecting" do
          click_button "Sign Up"
          last_user = User.last
          Fabricate(:subscription, user_id: last_user.id, provider: "github")
          visit new_subscription_path
          page.should have_content last_user.subscription("github").user_name
        end
        it "can authorize github" do
          pending
          click_button "Sign Up"
          click_link_or_button "Connect with Github"
          page.should have_content "Github account has been linked"
        end
        it "can choose not to authorize a service" do
          click_button "Sign Up"
          click_link_or_button "Skip this step"
          page.should have_content "account later"
        end
      end
    end
  end
end
