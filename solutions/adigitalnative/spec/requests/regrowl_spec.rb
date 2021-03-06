require 'spec_helper'

describe "Regrowl" do
  let!(:user) do
    FactoryGirl.create(:user_with_growls)
  end
  let!(:user2) do
    FactoryGirl.create(:user)
  end
  context "Refeeding an item" do
    it "regrowls" do
      Capybara.app_host = "http://#{user.display_name}.hungrlr.dev"
      login(user2)
      visit root_path
    end
  end
end
