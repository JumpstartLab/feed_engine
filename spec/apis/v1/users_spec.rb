require 'spec_helper'

describe 'api/v1/users', type: :api do
  let!(:user)            { FactoryGirl.create(:user) }
  let!(:twitter_account) { TwitterAccount.create(nickname: "test") }
  let(:url)              { "http://api.hungrlr.dev/v1/users" }

  context "Is not accessible without a user token" do
    before { get "#{url}.json" }
    it "should return a 401" do
      last_response.status.should == 401
    end
  end

  context "Pulls tweet information" do
    before(:each) do
      TwitterAccount.any_instance.stub(:user).and_return(user)
      user.stub(:has_tweets?).and_return(false)

      get "#{url}.json", token: user.authentication_token
    end

    it "returns a successful response" do
      last_response.status.should == 200
    end

    it "returns the first users id in the response" do
      response = JSON.parse(last_response.body)
      response["accounts"].first["nickname"].should == twitter_account.nickname
    end
  end
end