require 'spec_helper'

describe 'api/v1/feed', type: :api do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let!(:token) { user.authentication_token }
  
  context "growls viewable by this user" do
    # visit new_user_session_path(user)
    let(:url) { "http://api.hungrlr.com/v1/feeds/#{user.display_name}" }
    before(:each) do
      get "#{url}.json"
    end
    describe "json" do
      it "returns a successful response" do
        last_response.status.should == 200
      end
      it "returns the specified users last 3 growls" do
        # growls_json = user.growls.as_json
        # JSON.parse(last_response.body)["most_recent"].should == growls_json
        pending
      end
    end
  end

  context "creating growls through the api" do
    let(:message) { FactoryGirl.build(:message) }
    let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}" }
    before(:each) do
    end

    describe "when valid parameters are passed in" do
      it "returns a successful response" do
        post "#{url}.json", token: user.authentication_token, body: { type: "Message", comment: message.comment }
        last_response.status.should == 201
      end
    end

    describe "when invalid parameters are passed in" do
      it "returns a unsuccessful response" do
        post "#{url}.json", token: user.authentication_token, body: { type: "Message" }
        last_response.status.should == 406
        last_response.body.should =~ /"You must provide a message."/
      end
    end
  end
end
