require 'spec_helper'

describe "API feeds/user/... ", :type => :api do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, display_name: "user2",
                                    email: "user2@badger.com") }
  let(:token) { user.authentication_token }

  before do
    5.times do
      item = FactoryGirl.create(:text_item)
      user.text_items << item
      user.add_stream_item(item)
    end
    5.times do
      item = FactoryGirl.create(:image_item)
      user.image_items << item
      user.add_stream_item(item)
    end
    5.times do
      item = FactoryGirl.create(:link_item)
      user.link_items << item
      user.add_stream_item(item)
    end
    5.times do
      item = FactoryGirl.create(:text_item, body: "user2 comment")
      user2.text_items << item
      user2.add_stream_item(item)
    end
  end

  context "creating feed items via the API" do
    let(:url) { "http://api.example.com#{v1_feeds_user_stream_items_path(user)}" }

    it "creates a text_item via the api" do
      body = '{"type":"TextItem","body": "I had some really good Chinese food for lunch today."}'
      post "#{url}.json", :token => token, :body => body

      last_response.status.should == 201

      new_post = StreamItem.translate_item(user.stream_items.last)
      new_post.body.should == "I had some really good Chinese food for lunch today."
      new_post.should be_a(TextItem)
    end

    it "creates a link_item via the api" do
      body = '{"type":"LinkItem","comment": "I love Flash games", "link_url": "http://www.games.com/awesome.swf"}'
      post "#{url}.json", :token => token, :body => body

      last_response.status.should == 201

      new_post = StreamItem.translate_item(user.stream_items.last)
      new_post.comment.should == "I love Flash games"
      new_post.url.should == "http://www.games.com/awesome.swf"
      new_post.should be_a(LinkItem)
    end

    it "creates an image_item via the api" do
      body = '{"type":"ImageItem","comment": "This image is cool.", "image_url": "http://foo.com/cat.jpg"}'
      post "#{url}.json", :token => token, :body => body

      last_response.status.should == 201

      new_post = StreamItem.translate_item(user.stream_items.last)
      new_post.comment.should == "This image is cool."
      new_post.url.should == "http://foo.com/cat.jpg"
      new_post.should be_a(ImageItem)
    end

    it "responds with errors for an invalid post" do
      body = '{"type":"ImageItem","comment": "This image is cool.", "image_url": "http://foo.com/cat.html"}'
      post "#{url}.json", :token => token, :body => body

      last_response.status.should == 406
      last_response.body.should include("must be jpg, bmp, png, or gif and start with http/https")
    end

  end

  context "getting a feed item" do
    let!(:stream_item) { user.stream_items.last }
    let(:url) { "http://api.example.com#{v1_feeds_user_stream_items_path(user)}" }

    it "returns a json representation for a text post" do
      item = user.text_items.last
      stream_item = user.stream_items.where(:streamable_id => item.id).where(:streamable_type => item.class.name).first
      url = v1_feeds_user_stream_item_path(user, stream_item)
      get "http://api.example.com#{url}.json", :token => token

      resp = JSON.parse(last_response.body)
      resp["id"].should == item.id
      resp["type"].should == item.class.name
      Date.parse(resp["created_at"]).should == Date.parse(item.created_at.to_s)
      resp["body"].should == item.body
      resp["link"].should == v1_feeds_user_stream_item_path(item.user, item.stream_items.first)
    end
  end

  context "getting the user's feed items" do
    let(:url) { "http://api.example.com#{v1_feeds_user_stream_items_path(user)}" }
    before(:each) { get "#{url}.json", :token => token }

    it "returns an array of most recent stream items as json" do
      stream_items = user.stream_items.order("created_at DESC")[0..11]

      feed = JSON.parse(last_response.body)
      feed["items"]["most_recent"].count.should == 12
      last_response.status.should == 200

    end

    it "includes the feed name in the response" do
      feed = JSON.parse(last_response.body)
      feed["name"].should == user.display_name
    end

    it "includes the user id in the response" do
      feed = JSON.parse(last_response.body)
      feed["id"].should == user.id
    end

    it "says whether the feed is private" do
      feed = JSON.parse(last_response.body)
      feed["private"].should == false
    end

    it "gives a link to the feed" do
      feed = JSON.parse(last_response.body)
      feed["link"].should == v1_feeds_user_stream_items_path(user)
    end

    it "gives a link to the first_page" do
      feed = JSON.parse(last_response.body)
      feed["items"]["first_page"].should == v1_feeds_user_stream_items_path(user, :page => 1)
    end

    it "gives a link to the last_page" do
      feed = JSON.parse(last_response.body)
      feed["items"]["last_page"].should == v1_feeds_user_stream_items_path(user, :page => (user.stream_items.count/12.0).ceil)
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
        feed["items"]["most_recent"].first.keys.should include(key)
      end

    end
  end
end
