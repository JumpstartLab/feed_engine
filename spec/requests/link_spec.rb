require 'spec_helper'

describe Link do
  let(:user) { FactoryGirl.create(:user)}
  describe "Creating a link" do
    before(:each) do
      login(user)
      visit dashboard_path
    end

    it "passes" do
      within("#link_form") do
        fill_in "growl[link]", :with => "http://abc.com/"
        fill_in "growl[comment]", :with => "wooo"
        click_link_or_button "Growl Link"
      end
      page.should have_content "Your link has been created."
    end

    context "When I do not input a link" do
      it "fails" do
        within("#link_form") do
          fill_in "growl[link]", :with => ""
          fill_in "growl[comment]", :with => "I love this site!"
          click_on "Growl Link"
        end
        page.should have_content "You must provide a link."
      end
    end
  end
end
