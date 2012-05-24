require 'spec_helper'

describe SubscriptionJob, :job => :subscription do
  it "enqueues a external provider job" do
    user = double
    auth = double("Authentication", :provider => "twitter", :user => user)
    Authentication.stub(:all).and_return([auth])
    Resque.should_receive(:enqueue).with(TwitterJob, user, auth)
    SubscriptionJob.perform
  end

  it "enqueues a internal job" do
    follower = double
    subscription = double("Subscription", :follower => follower)
    Subscription.stub(:all).and_return([subscription])
    Resque.should_receive(:enqueue).with(RefeedJob, follower, subscription)
    SubscriptionJob.perform
  end
end
