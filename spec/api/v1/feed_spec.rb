require 'spec_helper'

describe "API feeds/user/... ", :type => :api do
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

  context "creating feed items via the API" do
    let(:url) { api_v1_feeds_user_stream_items_path(user) }

    it "creates a text_item via the api" do
      new_post_json = "{'type': 'TextItem','text': 'I had some really good Chinese food for lunch today.'}"
      post "#{url}.json", :token => token, :body => new_post_json

      raise last_response.inspect

    end

  end

  context "getting the user's feed items" do
    let(:url) { api_v1_feeds_user_stream_items_path(user) }
    before(:each) { get "#{url}.json", :token => token }

    it "returns an array of most recent stream items as json" do
      stream_items = user.stream_items.order("created_at DESC")[0..11]

      expected_json = StreamItem.translate_batch(stream_items).to_json
      feed = JSON.parse(last_response.body)
      feed.should include(expected_json)
      last_response.status.should == 200

    end

    it "formats the json response for an image_item " do
      new_url = "http://worace.com/workshop.png"
      comment = "wonderful wares whenever worace wants"

      new_image_item = user.image_items.create(:comment => comment, :url => new_url)
      user.add_stream_item(new_image_item)

      #set the created_at to make the item come first
      user.stream_items.find_by_streamable_id(new_image_item.id).created_at = Date.today+100000

      get "#{url}.json", :token => token
      feed = JSON.parse(last_response.body)

      expected_keys = ["type", "image_url", "created_at", "id", "feed", "link", "refeed", "refeed_link"]

      expected_keys.each do |key|
        feed.first.keys.should include(key)
      end

    end
  end
end
