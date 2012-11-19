require 'spec_helper'

describe Authentication do
  let(:user) { FactoryGirl.create(:user) }
  let(:new_auth) { Authentication.new }

  describe ".add_twitter" do
    let(:data) { "" }
    it "should call to create a twitter authentication record and add account details" do
      Authentication.should_receive(:create_twitter_auth).and_return(new_auth)
      new_auth.should_receive(:create_twitter_details).and_return(true)
      Authentication.add_twitter(user, data)
    end
  end

  describe ".add_github" do
    let(:data) { "" }
    it "should call to create a github authentication record and add account details" do
      Authentication.should_receive(:create_github_auth).and_return(new_auth)
      new_auth.should_receive(:create_github_details).and_return(true)
      Authentication.add_github(user, data)
    end
  end

  describe ".add_instagram" do
    let(:data) { "" }
    it "should call to create a instagram authentication record and add account details" do
      Authentication.should_receive(:create_instagram_auth).and_return(new_auth)
      new_auth.should_receive(:create_instagram_details).and_return(true)
      Authentication.add_instagram(user, data)
    end
  end

  describe "#create_twitter_auth" do
    let(:data) { JSON.parse(File.read("#{::Rails.root}/spec/fixtures/service_responses/twitter_response.json")) }
    it "should create a entry in TwitterAuth token with data returned from the API" do
      Authentication.create_twitter_auth(user, data)
      Authentication.count.should == 1
      Authentication.where(token: data["credentials"]["token"]).count.should == 1
      Authentication.where(secret: data["credentials"]["secret"]).count.should == 1
    end
  end

  describe "#create_twitter_details" do
    let(:data) { JSON.parse(File.read("#{::Rails.root}/spec/fixtures/service_responses/twitter_response.json")) }
    it "should create a entry in TwitterAccount with data returned from the API" do
      data.should_receive(:extra).and_return(OpenStruct.new(:raw_info => OpenStruct.new(:status => OpenStruct.new(:id_str => "1"))))
      new_auth.create_twitter_details(data)
      TwitterAccount.count.should == 1
      TwitterAccount.where(nickname: data["info"]["nickname"]).count.should == 1
      TwitterAccount.where(uid: data["uid"]).count.should == 1
    end
  end

  describe "#create_github_details" do
    let(:data) { JSON.parse(File.read("#{::Rails.root}/spec/fixtures/service_responses/github_response.json")) }
    it "should create a entry in GithubAccount with data returned from the API" do
      new_auth.create_github_details(data)
      GithubAccount.count.should == 1
    end
  end

  describe "#create_instagram_details" do
    let(:data) { JSON.parse(File.read("#{::Rails.root}/spec/fixtures/service_responses/instagram_response.json")) }
    it "should create a entry in InstagramAccount with data returned from the API" do
      expect{ new_auth.create_instagram_details(data) }.should change{ InstagramAccount.count }.by(1)
    end
  end

  describe ".twitter" do
    let!(:twitter_auth) { Authentication.create(provider: "twitter") }
    it "should return all twitter authentications" do
      Authentication.twitter.should == twitter_auth
    end
  end

  describe ".twitter?" do
    let!(:twitter_auth) { Authentication.create(provider: "twitter") }
    it "should return true if there is a twitter account in collection" do
      Authentication.twitter?.should == true
    end
  end

end
# == Schema Information
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  token      :string(255)
#  secret     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

