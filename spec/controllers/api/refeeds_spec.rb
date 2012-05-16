require 'spec_helper'

describe Api::RefeedsController, :type => :api do
  it "GET 'index' proper" do
    user1     = Factory.create(:user)
    user2     = Factory.create(:user)
    old_post = user1.posts.create(postable: TextPost.new(body: "Foo", title: "Bar"))

    request.host = "api.lvh.me"
    post :create, user_display_name: user1.display_name,
                  item_id:           old_post.id,
                  token:             user2.authentication_token,
                  format:            "json"

    response.header['Content-Type'].should include 'application/json'
    response.status.should == 201

    user2.posts.count.should == 1
    new_post = user2.posts.last
    new_post.refeed_id.should == old_post.id
    new_post.postable.body.should == "Foo"
    new_post.postable.title.should == "Bar"
  end

  it "GET 'index' with same user" do
    user     = Factory.create(:user)
    old_post = user.posts.create(postable: TextPost.new(body: "Foo", title: "Bar"))

    request.host = "api.lvh.me"
    post :create, user_display_name: user.display_name,
                  item_id:           old_post.id,
                  token:             user.authentication_token,
                  format:            "json"

    response.header['Content-Type'].should include 'application/json'
    response.status.should == 400
  end
end
