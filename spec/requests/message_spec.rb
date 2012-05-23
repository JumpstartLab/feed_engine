require 'spec_helper'

describe Message do
  let(:user) { FactoryGirl.create(:user)}
  describe "Creating a message" do
    before(:each) do
      login(user)
      visit dashboard_path
    end

    it "passes" do
      fill_in "growl[comment]", :with => "I love this site!"
      click_on "Growl Message"
      page.should have_content "Your message has been created."
    end

    it "fails" do
      fill_in "growl[comment]", :with => ""
      click_on "Growl Message"
      page.should have_content "You must provide a message."
    end
  end
end
