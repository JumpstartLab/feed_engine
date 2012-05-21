require 'spec_helper'

describe 'api/v1/user_tweets', type: :api do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:auth) { user.authentications.create(provider: "twitter") }
  let!(:twitter_account) { auth.create_twitter_account(nickname: "test") }
  let(:url) { "http://api.hungrlr.dev/v1/user_tweets" }

  context "Create tweet" do
    describe "when no user_id is passed in" do
      before(:each) do
        post "#{url}.json",  tweets: [ {:comment => "hello" } ].to_json, token: user.authentication_token
      end

      it "returns a 500 error" do
        last_response.status.should eq(500)
        last_response.body.should == "User account cannot be found."
      end
    end

    context "When tweet has valid parameters" do
      before(:each) do
        post "#{url}.json",  tweets: [ {:comment => "hello" } ].to_json, token: user.authentication_token, user_id: user.id
      end

      it "can create a tweet" do
        last_response.status.should eq(201)
        Tweet.last.comment.should == "hello"
      end
    end
  end
end
