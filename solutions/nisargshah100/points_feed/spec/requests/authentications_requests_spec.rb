require 'spec_helper'

describe Authentication do
  context "when I am logged in" do
    let(:user) { Fabricate(:user) }

    before(:each){
      visit new_user_session_path
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "Sign in"
    }

    context "and when I am on the dashboard page" do
      before(:each){
        visit dashboard_path
      }

      context "and I am on the services tab" do
        before(:each) {
          click_link "Services"
          authentication = Authentication.create(:provider => "twitter" )
          user.authentications << authentication
        }

        it "should let me see all accounts linked" do
          page.should have_content("#{user.authentications.first.provider}")
        end
      end
    end
  end
end