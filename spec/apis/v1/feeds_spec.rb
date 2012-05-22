require 'spec_helper'

describe 'api/v1/feed', type: :api do
  let!(:user) { FactoryGirl.create(:user_with_growls) }
  let!(:token) { user.authentication_token }
  let!(:other_user) { FactoryGirl.create(:user_with_growls) }

  context "growls viewable by this user" do
    let(:url) { "http://api.hungrlr.awesome/v1/feeds/#{user.display_name}" }
    before(:each) do
      FactoryGirl.create(:link, regrowled_from_id: other_user.growls.first.id, user: user)
      get "#{url}.json", token: user.authentication_token
    end
    describe "json" do
      it "returns a successful response" do
        last_response.status.should == 200
      end
      it "returns the specified users last 3 growls" do
        JSON.parse(last_response.body)["items"]["most_recent"].size == user.growls.size
      end
    end
  end

  context "creating messages through the api" do
    let(:message) { FactoryGirl.build(:message) }
    let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}/growls" }

    describe "when valid parameters are passed in" do
      it "returns a successful response" do
        post "#{url}.json", token: user.authentication_token, body: { type: "Message", comment: message.comment }.to_json
        last_response.status.should == 201
        user.messages.last.comment.should == message.comment
      end
    end

    describe "when invalid parameters are passed in" do
      it "returns a unsuccessful response" do
        post "#{url}.json", token: user.authentication_token, body: { type: "Message" }.to_json
        last_response.status.should == 406
        last_response.body.should =~ /"You must provide a message."/
      end
    end
  end

  context "creating images through the api" do
    let(:image) { FactoryGirl.build(:image) }
    let(:url) { "http://api.hungrlr.dev/v1/feeds/#{user.display_name}/growls" }

    describe "when valid parameters are passed in" do
      it "returns a successful response" do
        post "#{url}.json",  token: user.authentication_token,
                             body: { type: "Image",
                                     link: image.link,
                                     comment: image.comment }.to_json
        last_response.status.should == 201
        user.images.last.link.should == image.link
      end
    end

    describe "when invalid parameters are passed in" do
      it "returns a unsuccessful response" do
        post "#{url}.json", token: user.authentication_token,
                            body: { type: "Image", comment: image.comment }.to_json
        last_response.status.should == 406
        last_response.body.should =~ /"You must provide a link to an image."/
        last_response.body.should =~ /"URL must start with http and be a .jpg, .gif, or .png"/
        last_response.body.should =~ /"Given URL needs to be less then 2048 characters"/
        last_response.body.should =~ /"Photo does not exist"/
      end
    end
    describe "destroy through the API" do
      it "Can destroy image" do
        id = user.growls.first.id
        delete "http://api.hungrlr.dev/v1/feeds/#{user.display_name}/growls?id=#{id}", token: user.authentication_token
        last_response.status.should == 201
      end
    end
  end
end
