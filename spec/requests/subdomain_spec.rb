require 'spec_helper'

describe "Subdomains" do
  let!(:user) do
    FactoryGirl.create(:user)
  end

  context "no subdomain" do
    context "logged in" do
    end
    context "not logged in" do
    end
  end
  context "www" do

  end
  context "subdomain" do
    before(:each) do
      Capybara.app_host = "http://#{user.username}.hungry.test"
    end
  end
end