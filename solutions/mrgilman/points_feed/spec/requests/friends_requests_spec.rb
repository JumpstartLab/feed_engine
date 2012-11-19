require 'spec_helper'

describe "Friend" do
  context "when I am logged in" do
    let(:user) { Fabricate(:user) }
    let(:user2) { User.create(:email => "test2@test.com", :display_name => "testing2", :password => "hungry")}

    before(:each) {
      visit new_user_session_path
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "Sign in"
    }

    context "and when I visit a non-friends feed" do
      it "should allow me to subscribe to user" do
        pending
        visit "http://#{user2.display_name}.pf.dev"
        page.should have_content("Subscribe")
      end
    end

    context "and when I am on the dashboard page" do
      context "and when I am on the refeeds tab" do
        before(:each) do
          user.friends << user2
          visit dashboard_path
          click_link "Refeeds"
        end

        it "should show all of the user's friends" do
          page.should have_content("#{user2.display_name}")
        end

        it "should allow me to delete friends" do
          pending
          find(".feed-delete").click
          page.should_not have_content("#{user2.display_name}")
        end
      end
    end
  end
end