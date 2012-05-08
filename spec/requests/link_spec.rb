require 'spec_helper'

describe Link do
  describe "Creating a link" do
    before(:each) do
      visit new_link_path
    end

    it "passes" do
      fill_in "link[link]", :with => "http://abc.com"
      fill_in "link[comment]", :with => "wooo"
      click_on "Create Link"
      page.should have_content "Link posted succesfully."
    end

    context "When I do not input a link" do
      it "fails" do
        fill_in "link[link]", :with => ""
        fill_in "link[comment]", :with => "I love this site!"
        click_on "Create Link"
        page.should have_content "You must provide a link."
      end
    end
  end
end
