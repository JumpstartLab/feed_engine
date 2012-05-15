require 'spec_helper'

describe Api::FeedsController, :type => :api do
  it "returns feed" do
    user = Factory.create(:user)

    get :show, host: "api.lvh.me",
               id: user.display_name,
               token: user.authentication_token,
               format: "json"

    response.header['Content-Type'].should include 'application/json'
    response.status.should == 200
  end
end
