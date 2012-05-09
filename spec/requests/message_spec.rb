require 'spec_helper'

describe Message do
  let(:user) { FactoryGirl.create(:user)}
  describe "Creating a message" do
    before(:each) do
      login(user)
      visit new_message_path
    end

    it "passes" do
      fill_in "message[comment]", :with => "I love this site!"
      click_on "Create Message"
      page.should have_content "Message posted succesfully."
    end

    it "fails" do
      fill_in "message[comment]", :with => ""
      click_on "Create Message"
      page.should have_content "You must provide a message."
    end
  end
end
