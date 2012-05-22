require 'fast_spec_helper'
require 'app/lib/instagram_processor.rb'
require 'active_support/core_ext/object/blank'

describe Hungrlr::InstagramProcessor do
  context ".run" do
    it "create instagram photos for a collection of users" do
      account = double
      account.stub(:[]).with("nickname").and_return("nick")
      account.stub(:[]).with("last_status_id").and_return("status_id")
      account.stub(:[]).with("user_id").and_return("user_id")
      
      Net::HTTP.should_receive(:get)
      JSON.should_receive(:parse).and_return( { 'accounts' => [account] } )

      subject.should_receive(:get_tweets).with("nick", "status_id").and_return([])
      subject.should_receive(:build_tweet_hash).with([]).and_return([])
      subject.should_receive(:create_tweets_for_user).with("user_id", [])

      subject.run
    end
  end
end