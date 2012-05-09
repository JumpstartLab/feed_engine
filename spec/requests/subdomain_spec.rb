require 'spec_helper'

describe "Subdomains" do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  context "no subdomain" do
    context "logged in" do
      before(:each) do
        login(user)
        visit root_path
      end
      it "redirects to the user's dashboard" do
        page.should have_content "Dashboard"
        current_path.should == dashboard_path
      end
      context "www" do
        it "redirects to the user's dashboard" do
          page.should have_content "Dashboard"
          # check current_url
        end
      end
    end
    context "not logged in" do
      it "shows a link to sign up" do
        visit root_path
        page.should have_link "Sign Up"
      end
    end
  end

  context "subdomain" do
    before(:each) do
      Capybara.app_host = "http://#{user.username}.hungry.test"
    end
    it "shows the subdomain user's most recent messages" do
      pending
    end
  end
end