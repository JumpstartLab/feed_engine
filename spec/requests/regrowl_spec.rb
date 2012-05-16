require 'spec_helper'

describe "Regrowl" do
  let!(:user1) { FactoryGirl.create(:user_with_growls) }
  let!(:user2) { FactoryGirl.create(:user) }
  before(:each) do
    Capybara.app_host = "http://#{user2.display_name}.hungrlr.test"
    login(user2)
    visit "http://#{user1.display_name}.hungrlr.test"
  end
  context "Refeeding an item" do
    it "regrowls" do
      click_on "Regrowl"
      page.should have_content "Regrowl Successful"
    end
    it "displays on my feed" do
      click_on "Regrowl"
      visit "http://#{user2.display_name}.hungrlr.test"
      page.should have_content user2.display_name
    end
  end
end