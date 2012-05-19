require 'spec_helper'

describe "Subscribing to a User's feed" do
  let!(:user) { FactoryGirl.create(:user, :display_name => "wittyposter") }
  let(:user_2) { FactoryGirl.create(:user, :display_name => "smittenuser") }
  let!(:site_domain) { "http://#{user.display_name}.example.com" }

  before(:each) do
    5.times do
      text_item = FactoryGirl.create(:text_item, :user => user)
    end
  end

  context "when I am logged in" do
    before(:each) do
      login(user_2)
      visit site_domain
    end

    context "and I view another user's feed" do
      it "gives me the option to subscribe to that user's feed" do
        within(".feed-meta-container") do
          page.should have_link("TackleBox this Troutr")
        end
      end

      it "subscribes me to this user's feed when" do
        within(".feed-meta-container") do
          click_link_or_button("TackleBox this Troutr")
        end

      end
    end
  end
end
