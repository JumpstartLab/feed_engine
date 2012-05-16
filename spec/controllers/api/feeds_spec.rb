require 'spec_helper'

describe Api::FeedsController, :type => :api do
  it "GET 'show'" do
    user = Factory.create(:user)

    request.host = "api.lvh.me"
    get :show, id:     user.display_name,
               token:  user.authentication_token,
               format: "json",
               page:   1

    response.header['Content-Type'].should include 'application/json'
    response.status.should == 200
  end
end
