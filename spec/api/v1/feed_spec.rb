require 'spec_helper'

describe "API /user/id/feed/ ", :type => :api do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, display_name: "user2",
                                    email: "user2@badger.com") }
  let(:token) { user.authentication_token }

  before do
    10.times do
      item = FactoryGirl.create(:text_item)
      user.text_items << item
      user.add_stream_item(item)
    end
    10.times do
      item = FactoryGirl.create(:image_item)
      user.image_items << item
      user.add_stream_item(item)
    end
    10.times do
      item = FactoryGirl.create(:link_item)
      user.link_items << item
      user.add_stream_item(item)
    end
    10.times do
      item = FactoryGirl.create(:text_item, body: "user2 comment")
      user2.text_items << item
      user2.add_stream_item(item)
    end
  end

  context "getting the user's feed items" do
    let(:url) { api_v1_user_feed_path(user) }

    it "returns an array of json" do
      get "#{url}.json", :token => token

      feed_json = user.stream_items.all.to_json

      last_response.body.should == feed_json
      last_response.status.should == 200

      feed = JSON.parse(last_response.body)
    end
  end
end
