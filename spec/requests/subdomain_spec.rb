require 'spec_helper'

describe "Subdomains" do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let!(:second_user) { FactoryGirl.create(:user_with_growls) }

  context "no subdomain" do
    context "logged in" do
      before(:each) do
        Capybara.app_host = "http://hungrlr.test"
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
          current_path.should == dashboard_path
        end
      end
    end
    context "not logged in" do
      it "shows a link to sign up" do
        visit root_path
        page.should have_content "Sign up"
      end
    end
  end

  context "subdomain" do
    before(:each) do
      Capybara.app_host = "http://#{user.display_name}.hungry.test"
    end
    it "shows the subdomain user's most recent messages" do
      visit root_path
      page.should have_content "#{user.display_name.capitalize}'s Feed"
      user.growls.each do |growl|
        page.should have_content growl.comment if growl.comment.present?
        page.should have_content growl.link if growl.link?
      end
    end

    describe "logged in user visits another user's subdomain" do
      before do
        login(user)
        Capybara.app_host = "http://#{second_user.display_name}.hungry.test"
        visit root_path
      end
    end
  end
end
