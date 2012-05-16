require 'spec_helper'

describe "Regrowl" do
  let!(:user) do
    FactoryGirl.create(:user_with_growls)
  end
  let!(:user2) do
    FactoryGirl.create(:user)
  end
  context "Refeeding an item" do
    before(:each) do
      login(user)
      Capybara.app_host = "http://#{user.display_name}.hungry.dev"
      visit root_path
    end

    it "regrowls" do
      save_and_open_page
      click_on "Regrowl"
      page.should have_content "Regrowl Successful"
    end
    it "displays on my feed" do
      click_on "Regrowl"
      visit "http://#{user2.display_name}.hungrlr.dev"
      page.should have_content user2.display_name
    end
  end
end