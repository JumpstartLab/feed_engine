require 'spec_helper'

describe "Points" do
  context "Viewing feed with item with 20 points" do
    let!(:user) { FactoryGirl.create(:user_with_growls) }
    let!(:user2) { FactoryGirl.create(:user, password: "hungry") }
    context "User is logged in" do
      before(:each) do
        Capybara.app_host = "http://#{user.display_name}.hungrlr.dev"
        login(user2)
        visit root_path
      end
      it "adds a point when the user clicks it" do
        first("a.points_link").click
        first("span.points").should have_content "1"
        first("a.points_link").click
        first("span.points").should have_content "2"
      end
    end
    context "User is not logged in" do
      before(:each) do
        Capybara.app_host = "http://#{user.display_name}.hungrlr.dev"
        visit root_path
        first("a.points_link").click
      end
      it "invites the user to log in or sign up" do
        page.should have_content "Signup"
      end
      context "the user signs up" do
        before(:each) do
          fill_in "user[display_name]", with: "mike"
          fill_in "user[email]", with: "mike@innoblue.org"
          fill_in "user[password]", with: "hungry"
          fill_in "user[password_confirmation]", with: "hungry"
          click_button("Sign up, it's free!")
          click_link("Take me to my dashboard")
        end
        it "adds the points" do
          visit root_path
          first("span.points").should have_content "1"
        end
      end
      context "the user logs in" do
        before(:each) do
          login(user2)
        end
        it "adds the points" do
          visit root_path
          first("span.points").should have_content "1"
        end
        it "does not re-add points upon additional login" do
          logout
          login(user2)
          visit root_path
          first("span.points").should have_content "1"
        end
      end
      context "the user goes back to the feed without auth" do
        it "does not add points" do
          visit root_path
          first("span.points").should have_content "0"
        end
      end
    end
  end
end
