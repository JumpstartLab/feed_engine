require 'spec_helper'

describe "Feed" do
  describe "when a visitor views the root url" do
    it "displays the river" do
      visit root_url
      page.should have_content "What's new in the"
    end
  end
end