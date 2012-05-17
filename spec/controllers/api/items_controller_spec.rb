require 'spec_helper'

describe Api::V1::ItemsController do
  let(:user) { Fabricate(:user) }

  it "without a valid user token responds with unauthorized" do
    User.should_receive :find_by_api_key
    post :create, :format => :json
    response.code.should == '401'
  end

  describe "with a valid user token" do
    before(:all) do
      Api::V1::ItemsController.any_instance.stub(:authorized?).and_return true
    end

    it "responds with OK" do
      post :create, :format => :json
      response.code.should == '200'
    end

    it "creates an item" do
      post :create, :post => {'body' => 'hi there', 'user_id' => '2'}
    end
  end
end
