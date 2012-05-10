require 'spec_helper'

describe Image do
  describe "Creating an image" do
    let(:user) { FactoryGirl.create(:user)}
    before(:each) do
      login(user)
      visit new_image_path
    end
    it "fails" do
      fill_in "image[link]", :with => "abc123"
      click_on "Create Image"
      page.should have_content "There was an error saving this image"
    end
    it "passes" do
      fill_in "image[link]", :with => "http://www.justanimal.org/images/gorilla-10.jpg"
      fill_in "image[comment]", :with => "wooo"
      click_on "Create Image"
      page.should have_content "Image posted succesfully."
    end
  end
end