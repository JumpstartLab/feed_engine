require 'spec_helper'

# describe TwitterJob do
#   subject do
#     described_class { 'id' => "1", 'token' => '', 'secret' => '', 'uid' => uid }
#   end

#   let(:uid) { "1" }
#   let(:twitter_client) do
#     mock('twitter client')
#   end

#   let(:last_tweet_id) { 12 }

#   before do
#     subject.stub(:twitter_client).and_return(twitter_client)
#     subject.stub(:users_last_tweet_id).and_return(last_tweet_id)
#   end

#   it "should ask the twitter client for the user timeline" do
#     twitter_client.should_receive(:user_timeline).with(uid.to_i,:since_id => last_tweet_id)
#   end
# end