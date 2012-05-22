require 'spec_helper'

describe 'api/v1/users', type: :api do
  let!(:user)            { FactoryGirl.create(:user) }
  let!(:twitter_account) { TwitterAccount.create(nickname: "test") }
  let!(:github_account) { GithubAccount.create(nickname: "test") }
  let!(:authentication) { user.authentications.create(user: user, provider: "Instagram", token: "hello")}
  let!(:instagram_account) { authentication.create_instagram_account(nickname: "test") }

  let(:twitter)   { "http://api.hungrlr.dev/v1/users/twitter" }
  let(:instagram) { "http://api.hungrlr.dev/v1/users/instagram" }
  let(:github)    { "http://api.hungrlr.dev/v1/users/github" }

  context "Is not accessible without a user token" do
    before { get "#{twitter}.json" }
    it "should return a 401" do
      last_response.status.should == 401
    end
  end

  context "Pulls tweet information" do
    before(:each) do
      TwitterAccount.any_instance.stub(:user).and_return(user)
      get "#{twitter}.json", token: user.authentication_token
    end

    it "returns a successful response" do
      last_response.status.should == 200
    end

    it "returns the first users id in the response" do
      response = JSON.parse(last_response.body)
      response["accounts"].first["nickname"].should == twitter_account.nickname
    end
  end
  context "Pulls Github Information" do
    before(:each) do
      GithubAccount.any_instance.stub(:user).and_return(user)
      get "#{github}.json", token: user.authentication_token
    end
    it 'returns a succesful response' do
      last_response.status.should == 200
    end
  end
  context "Pulls Instagram Information" do
    before(:each) do
      get "#{instagram}.json", token: user.authentication_token
    end
    it 'returns a succesful response' do
      last_response.status.should == 200
    end
  end
end