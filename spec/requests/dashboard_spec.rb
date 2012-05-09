require 'spec_helper'

describe "Dashboard" do
  describe "GET /dashboard" do
    it "has a dashboard page" do
      visit "/dashboard"
      page.should have_content "Dashboard"
    end
  end

  context "creating new posts" do
    before(:each) { visit "/dashboard" }
    describe "of text type" do
      it "displays the form" do
        page.should have_content "Create Text Post"
      end

      it "prevents creation of posts longer than 512 characters" do
        bad_body = "a" * 513
        fill_in "text_item[body]", :with => bad_body
        click_on "Textify"
        page.should have_content "Post is invalid"
      end

      it "successfully adds a valid post" do
        valid_post = "I'm a valid post. Huzzah!"
        fill_in "text_item[body]", :with => valid_post
        click_on "Textify"
        page.should have_content valid_post
      end
    end
  end
end