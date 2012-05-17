require 'spec_helper'

describe Api::ItemsController, :type => :api do
  it "GET 'index'" do
    user = FactoryGirl.create(:user)
    user.posts.create!(postable: TextPost.new(body: "foo", title: "blah"))

    request.host = "api.lvh.me"
    get :index, user_display_name: user.display_name,
                token:             user.authentication_token,
                format:            "json"

    response.header['Content-Type'].should include 'application/json'
    response.header['Link'].should include \
      "<http://api.lvh.me/feeds/#{user.display_name}/items?page=1>; rel=\"next\", <http://api.lvh.me/feeds/#{user.display_name}/items?page=1>; rel=\"last\""
    response.status.should == 200
  end
end
