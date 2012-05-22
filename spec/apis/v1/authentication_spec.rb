require 'spec_helper'

describe "API errors", :type => :api do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}" }

  context "making a request with no token" do

    it "returns the message 'Token is invalid'" do
      get "http://api.hungrlr.dev/v1/validate_token.json", :token => "sdfds"
      last_response.status.should == 401
    end
    it "token is valid" do
      get "http://api.hungrlr.dev/v1/validate_token.json", :token => user.authentication_token
      last_response.status.should == 200
    end
  end

end