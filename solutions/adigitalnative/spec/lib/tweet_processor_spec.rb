require 'simplecov'
SimpleCov.start 'rails'

require 'fast_spec_helper'
require 'app/lib/tweet_processor'
require 'active_support/core_ext/object/blank'

class TweetApiService
end

describe Hungrlr::TweetProcessor do
  context ".run" do
    it "create tweets for a collection of users" do
      account = double
      account.stub(:[]).with("nickname").and_return("nick")
      account.stub(:[]).with("last_status_id").and_return("status_id")
      account.stub(:[]).with("user_id").and_return("user_id")

      subject.should_receive(:get_tweets).with("nick", "status_id").and_return([])
      api_service = double

      subject.stub(:api_service => api_service)
      api_service.should_receive(:twitter_accounts).and_return([account])
      api_service.should_receive(:build_tweet_hash).with([]).and_return([])
      api_service.should_receive(:create_tweets_for_user).with("user_id", [])

      subject.run
    end
  end
end