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
    end
  end
end