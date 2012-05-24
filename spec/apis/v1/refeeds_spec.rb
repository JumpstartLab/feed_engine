require 'spec_helper'

describe "Refeeds", :type => :api do
  let!(:user)  { FactoryGirl.create(:user_with_growls) }
  let!(:user2) { FactoryGirl.create(:user_with_growls) }
  let!(:token) { user2.authentication_token }
  let(:happy_url)   { "http://api.hungrlr.awesome/v1/feeds/#{user.display_name}/growls/#{Growl.first.id}/refeed" }
  let(:unhappy_url) { "http://api.hungrlr.awesome/v1/feeds/#{user.display_name}/growls/#{Growl.last.id}/refeed"  }
  context "refeed an item" do
    before(:each) do
      post "#{happy_url}.json", token: user2.authentication_token
    end
    it "returns a successful response" do
      # raise [Growl.all].inspect
      last_response.status.should == 201
    end
  end
  context "When regrowling your own growl" do
    it "Has an error" do
      post "#{unhappy_url}.json", token: user2.authentication_token
      last_response.status.should == 400
    end
  end

end