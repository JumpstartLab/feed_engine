require 'spec_helper'

describe "Subscriptions" do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let!(:user2) { FactoryGirl.create(:user_with_growls) }
  context "Subscribe & Unsubscribe from feed" do
    before(:each) do
      Capybara.app_host = "http://#{user2.display_name}.hungrlr.test"
      login(user)
      visit root_path
    end

    it "can subscribe to the visited user" do
      click_link_or_button("SUBSCRIBE")
      user2.subscribers.include?(user).should == true
    end

    it "can end the subscription" do
      user2.subscribers.include?(user).should == false
    end
  end
  context "Unsubscribe from manager" do
    let!(:subscription) { user.inverse_subscriptions.create(user_id: user2.id,
                                                            last_status_id: DateTime.now.to_i)}
    before(:each) do
      Capybara.app_host = "http://hungrlr.test"
      login(user)
      visit subscriptions_path
    end
    it "can unsubscribe" do
      user2.subscribers.include?(user).should == true
      click_link_or_button "UNSUBSCRIBE"
      user2.subscribers.include?(user).should == false
    end
  end
end