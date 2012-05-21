# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_name  :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Subscription do

  describe ".create_with_omniauth(auth, user)" do
    it "creates a new subscription with auth info" do
      auth = { "provider" => "twitter",
               "uid" => "asdfj3948d",
               "info" => { "nickname" => "travis" },
               "credentials" => { "token" => "testtoken", "secret" => "testsecret"} }
      user = Fabricate(:user)
      Subscription.create_with_omniauth(auth, user)
      Subscription.all.count.should == 1
    end
  end

  context "when getting new service posts" do

    let!(:old_post) { OpenStruct.new(created_at: Time.now) }
    let!(:twitter_subscription) { Fabricate(:subscription, provider: "twitter") }
    let!(:github_subscription) { Fabricate(:subscription, provider: "github") }
    let!(:new_enough_post) { OpenStruct.new(created_at: Time.now) }

    describe "#get_new_posts" do

      it "returns all posts since the service was created" do
        Subscription.any_instance.stub(:posts_for).and_return([new_enough_post])
        twitter_subscription.get_new_posts.should == [new_enough_post]
        github_subscription.get_new_posts.should == [new_enough_post]
      end
      it "does not return posts from before the subscription was created" do
        Subscription.any_instance.stub(:posts_for).and_return([old_post])
        twitter_subscription.get_new_posts.should == []
        github_subscription.get_new_posts.should == []
      end

      it "does not return posts that have already been created" do
        pending
        Subscription.any_instance.stub(:posts_for).and_return([new_enough_post])
        twitter_subscription.get_new_posts
        twitter_subscription.get_new_posts.should == []
        github_subscription.get_new_posts
        github_subscription.get_new_posts.should == []
      end
    end

    describe "#create_records_of_posts(new_posts)" do
      let!(:twitter_new_posts) { [ OpenStruct.new(text: "Random body", created_at: Time.now)] }
      let!(:github_new_posts) { [ OpenStruct.new(repo: OpenStruct.new(name: "repo"), type: "PushEvent", created_at: Time.now)] }

      it "creates new twitter posts" do
        twitter_subscription.create_records_of_posts(twitter_new_posts)
        Tweet.all.size.should == 1
        Tweet.first.body.should == twitter_new_posts.first.text
      end

      it "creates new github posts" do
        github_subscription.create_records_of_posts(github_new_posts)
        GithubEvent.all.size.should == 1
        GithubEvent.first.repo.should == github_new_posts.first.repo.name
        GithubEvent.first.event_type.should == github_new_posts.first.type
      end
    end

    describe "#tweets" do
      let!(:tweet) { Fabricate(:tweet, subscription_id: twitter_subscription.id) }
      it "returns the subscription's tweets" do
        twitter_subscription.tweets.first.should == tweet
      end
    end
    describe "#github_events" do
      let!(:github_event) { Fabricate(:github_event, subscription_id: github_subscription.id) }
      it "returns the subscription's github_events" do
        github_subscription.github_events.first.should == github_event
      end
    end
  end
end
