require 'spec_helper'

describe 'api/v1/user_tweets', type: :api do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:auth) { user.authentications.create(provider: "twitter") }
  let(:url) { "http://api.hungrlr.dev/v1/user_tweets" }

  context "Create tweet" do
    it "can create a tweet" do
      post "#{url}.json",  tweets: [ {:comment => "hello" } ].to_json, token: user.authentication_token
      last_response.status.should eq(201)
      Tweet.last.comment.should == "hello"
    end
  end
end