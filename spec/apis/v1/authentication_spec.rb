require 'spec_helper'

describe "API errors", :type => :api do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}" }

  it "making a request with no token" do
    get "#{url}.json", :token => ""
    error = "Token is invalid."
    last_response.body.should eql(error.to_json)
  end

end