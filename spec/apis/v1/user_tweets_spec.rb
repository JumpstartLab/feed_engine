require 'spec_helper'

describe 'api/v1/user_tweets', type: :api do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:auth) { user.authentications.create(provider: "twitter")}
  let(:url) { "http://api.hungrlr.awesome/v1/user_tweets" }
  context "Pulls tweet information" do
    before(:each) do
      get "#{url}.json"
    end
    it "returns a successful response" do
      last_response.status.should == 200
    end
    it "returns the first users id in the response" do
      response = JSON.parse(last_response.body)
      response["users"].first["id"].should == user.id
    end
    it "has auth" do
      User.find_twitter_users.first.id.should == user.id
    end
  end
  context "Create tweet" do
    it "can create a tweet" do
      # post "#{url}",  tweets: [ { link: "sweeet", comment: "duuude"} ].to_json
      # last_response.status.should eq(201)
      # Tweet.last.comment.should == "duuude"
      pending "IDK..."
    end
  end
end