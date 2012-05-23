require 'spec_helper'

describe "Search" do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let!(:user2) { FactoryGirl.create(:user) }
  before(:each) do
    Capybara.app_host = "http://hungrlr.test"
    login(user2)
    visit root_path
  end
  it "takes the user to the specified feed" do
    fill_in"display_name", with: user.display_name
    click_button("Search")
    page.should have_content "#{user.display_name}'s Feed"
  end
end
