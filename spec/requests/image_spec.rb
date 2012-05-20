require 'spec_helper'

describe Image do
  describe "Creating an image" do
    let(:user) { FactoryGirl.create(:user)}
    before(:each) do
      login(user)
      visit dashboard_path
      click_on "+ Image"
    end
    it "fails" do
      fill_in "growl[link]", :with => "abc123"
      click_on "Create Image"
      pending "ERROR MESSAGE SHOULD BE MORE SPECIFIC"
      # XXX ERROR MESSAGE SHOULD BE MORE SPECIFIC.
      page.should have_content "There was an error saving this image."
    end
    it "passes" do
      fill_in "growl[link]", :with => "http://www.justanimal.org/images/gorilla-10.jpg"
      #XXX NOT FILLING IN THE RIGHT GROWL COMMENT... NEED TO DO WITHIN ACTIVE SCOPE?
      fill_in "growl[comment]", :with => "wooo"
      click_on "Create Image"
      page.should have_content "Your image has been created."
    end
  end
end