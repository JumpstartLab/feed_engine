require "spec_helper"

describe "/api/v1/:display_name/growls", :type => :api do
  let(:user) { FactoryGirl.create(:user_with_growls) }
  let(:token) { user.authentication_token }
  let(:url) { "/api/v1/#{user.display_name}/growls" }

  context "items viewable by this user" do
    it "json" do
      get "#{url}.json"
      growls_json = user.growls.to_json
      last_response.body.should eql(growls_json)
      last_response.status.should eql(200)
    end
  end

  describe "when the API is passed valid parameters" do
    let!(:message_json) { { type: "Message", comment: "I had some really good Chinese food for lunch today." }.to_json }
    
    it "returns a 201 and creates the message" do
      post "#{url}.json", :body => { type: "Message", comment: "I had some really good Chinese food for lunch today." }

      last_response.status.should eql(201)
      user.messages.last.comment.should == JSON.parse(message_json)['comment']
    end
  end
end