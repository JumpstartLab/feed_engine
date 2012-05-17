require 'spec_helper'

describe Api::V1::ItemsController do
  let(:user) { Fabricate(:user) }

  it "without a valid user token responds with unauthorized" do
    User.should_receive :find_by_api_key
    post :create, :format => :json
    response.code.should == '401'
  end

  describe "with a valid user token", :focus => true do
    it "responds with OK" do
      post :create,
           :format => :json,
           :display_name => user.display_name,
           :api_key => user.api_key
      response.code.should == '200'
    end

    it "creates an item" do
      Item.should_receive :create
      post :create,
           :format => :json,
           :display_name => user.display_name,
           :api_key => user.api_key,
           :post => { 'type' => 'message',
                      'body' => 'Lovebuckets!'}
    end

    it "persists a message for a user with correct attributes" do
      Message.should_receive :create
      expect do
        post :create,
           :format => :json,
           :display_name => user.display_name,
           :post => { 'type' => 'message',
                      'body' => 'Lovebuckets!',
                      'api_key' => user.api_key }
      end.to change { Message.count }.from(0).to(1)
      message = Message.first
      user.posts.should include message
      message.body.should == 'Lovebuckets!'
    end
  end
end
