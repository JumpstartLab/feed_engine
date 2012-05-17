require 'spec_helper'

describe "API errors", :type => :api do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}" }

  context "making a request with no token" do

    it "returns the message 'Token is invalid'" do
      get "#{url}.json", :token => ""
      error = "Token is invalid."
      last_response.body.should eql(error)
    end

    it "returns an error 401" do
      get "#{url}.json", :token => ""
      last_response.status.should == 401
    end
  end

end