require 'spec_helper'

describe "API authentication ", :type => :api do
  let!(:user) { FactoryGirl.create(:user) }
  it "returns an error for a request with no token" do
    url = api_v1_user_feed_path(user)
    get "#{url}.json", :token => ""
    error = { :error => "Token is invalid." }
    last_response.body.should == (error.to_json)
  end
end
