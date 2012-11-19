require 'spec_helper'

describe Subscription do
  let!(:user) { FactoryGirl.create(:user, :display_name => "wittyposter") }
  let(:user_2) { FactoryGirl.create(:user, :display_name => "smittenuser") }

  it "prevents a user from subscribing to themself" do
    new_sub = user.subscriptions.new(:followed_user_id => user.id)
    new_sub.should_not be_valid
  end

  it "prevents duplicate subscriptions" do
    new_sub = user.subscriptions.new(:followed_user_id => user_2.id)
    new_sub.save
    dup_sub = user.subscriptions.new(:followed_user_id => user_2.id)
    dup_sub.should_not be_valid
  end
end
