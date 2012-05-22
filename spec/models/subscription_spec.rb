# == Schema Information
#
# Table name: subscriptions
#
#  id           :integer         not null, primary key
#  provider     :string(255)
#  uid          :string(255)
#  user_name    :string(255)
#  user_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#

require 'spec_helper'

describe Subscription do

  describe ".create_with_omniauth(auth, user)" do
    let(:user) { Fabricate(:user) }
    it "creates a new subscription with auth info" do
      auth = { "provider" => "twitter",
               "uid" => "asdfj3948d",
               "info" => { "nickname" => "travis" },
               "credentials" => { "token" => "testtoken", "secret" => "testsecret"} }
      Subscription.create_with_omniauth(auth, user)
      Subscription.all.count.should == 1
    end
  end

  context "when getting new service posts" do

    let!(:consuming_user) { Fabricate(:user) }
    let!(:feeding_user) { Fabricate(:user) }
    let!(:old_post) { OpenStruct.new(created_at: Time.now) }
    let!(:fabricated_subscriptions) {{
      :twitter_subscription   => Fabricate(:subscription, provider: "twitter"),
      :github_subscription    => Fabricate(:subscription, provider: "github"),
      :instagram_subscription => Fabricate(:subscription, provider: "instagram"),
      :refeed_subscription    => Fabricate(:subscription, provider: "refeed", uid: feeding_user.id, user_id: consuming_user.id)
    }}
    let!(:new_enough_post) { OpenStruct.new(created_at: Time.now) }

    describe "#get_new_posts" do
      it "returns all posts since the subscription was created" do
        Subscription.any_instance.stub(:posts_for).and_return([new_enough_post])
        fabricated_subscriptions.each do |name, subscription|
          subscription.get_new_posts.should == [new_enough_post]
        end
      end
      it "does not return posts from before the subscription was created" do
        Subscription.any_instance.stub(:posts_for).and_return([old_post])
        fabricated_subscriptions.each do |name, subscription|
          subscription.get_new_posts.should == []
        end
      end

      it "does not return posts that have already been created" do
        Subscription.any_instance.stub(:posts_for).and_return([new_enough_post])
        fabricated_subscriptions.each do |name, subscription|
          subscription.get_new_posts
          subscription.get_new_posts.should == []
        end
      end
    end

    describe "#create_records_of_posts(new_posts)" do
      let!(:twitter_new_posts) { [ OpenStruct.new(text: "Random body", created_at: Time.now)] }
      let!(:github_new_posts) { [ OpenStruct.new(repo: OpenStruct.new(name: "repo"), type: "PushEvent", created_at: Time.now)] }
      let!(:instagram_new_posts) { [ OpenStruct.new(images: { "standard_resolution" => { "url" => "http://travis.com/travis.jpg" } }, caption: { "text" => "random image"}, created_at: Time.now  )] }

      it "creates new twitter posts" do
        fabricated_subscriptions[:twitter_subscription].create_records_of_posts(twitter_new_posts)
        Tweet.all.size.should == 1
        Tweet.first.body.should == twitter_new_posts.first.text
      end

      it "creates new github posts" do
        fabricated_subscriptions[:github_subscription].create_records_of_posts(github_new_posts)
        GithubEvent.all.size.should == 1
        GithubEvent.first.repo.should == github_new_posts.first.repo.name
        GithubEvent.first.event_type.should == github_new_posts.first.type
      end

      it "creates new instagram posts" do
        fabricated_subscriptions[:instagram_subscription].create_records_of_posts(instagram_new_posts)
        Instapound.all.size.should == 1
        Instapound.first.image_url.should == instagram_new_posts.first.images["standard_resolution"]["url"]
        Instapound.first.body.should == instagram_new_posts.first.caption["text"]
      end
    end

    describe "#tweets" do
      let!(:tweet) { Fabricate(:tweet, subscription_id: fabricated_subscriptions[:twitter_subscription].id) }
      it "returns the subscription's tweets" do
        fabricated_subscriptions[:twitter_subscription].tweets.first.should == tweet
      end
    end
    describe "#github_events" do
      let!(:github_event) { Fabricate(:github_event, subscription_id: fabricated_subscriptions[:github_subscription].id) }
      it "returns the subscription's github_events" do
        fabricated_subscriptions[:github_subscription].github_events.first.should == github_event
      end
    end
    describe "#instapounds" do
      let!(:instapound) { Fabricate(:instapound, subscription_id: fabricated_subscriptions[:instagram_subscription].id) }
      it "returns the subscription's github_events" do
        fabricated_subscriptions[:instagram_subscription].instapounds.first.should == instapound
      end
    end
    describe "#get_tweets" do
      it "returns tweets"
      it "returns tweets for the subscription"
    end
    describe "#get_github_events" do
      it "returns github_events"
      it "returns github_events for the subscription"
      it "only returns PushEvents, CreateEvents, and ForkEvents"
    end
    describe "#get_instapounds" do
      it "returns instagrams"
      it "returns instagrams for the subscription"
    end
  end
end
