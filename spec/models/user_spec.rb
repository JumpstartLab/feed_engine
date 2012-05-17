require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:link_item) { FactoryGirl.create(:link_item) }
  let(:text_item) { FactoryGirl.create(:text_item) }
  let(:image_item) { FactoryGirl.create(:image_item) }


  context "#add_stream_item" do
    it "adds a link item" do
      user.add_stream_item(link_item)
      user.stream_items.last.streamable.should == link_item
    end
    it "adds an image_item" do
      user.add_stream_item(image_item)
      user.stream_items.last.streamable.should == image_item
    end
    it "adds a text_item" do
      user.add_stream_item(text_item)
      user.stream_items.last.streamable.should == text_item
    end
  end

  context "#new_stream_item_from_json" do
    it "returns a text_item for a request with type text_item" do
      body = '{"type":"TextItem","body": "I had some really good Chinese food for lunch today."}'
      parsed_json = JSON.parse(body)
      item = StreamItem.new_stream_item_from_json(user.id, parsed_json)
      item.should be_a(TextItem)
      item.body.should == "I had some really good Chinese food for lunch today."

      item.save
      user.text_items.last.should == item
      user.stream_items.last.streamable.should == item
    end

    it "returns a link_item for a request with type link_item" do
      body = '{"type":"LinkItem","comment": "I love Flash games.","link_url":"http://www.games.com/awesome.swf"}'
      parsed_json = JSON.parse(body)

      item = StreamItem.new_stream_item_from_json(user.id, parsed_json)

      item.should be_a(LinkItem)
      item.url.should == "http://www.games.com/awesome.swf"
      item.comment.should == "I love Flash games."
      item.save
      user.link_items.last.should == item
      user.stream_items.last.streamable.should == item
    end

    it "returns an image_item for a request with type image_item" do
      body = '{"type":"ImageItem","comment": "This image is cool.", "image_url":"http://foo.com/cat.jpg"}'
      parsed_json = JSON.parse(body)

      item = StreamItem.new_stream_item_from_json(user.id, parsed_json)

      item.should be_a(ImageItem)
      item.comment.should == "This image is cool."
      item.url.should == "http://foo.com/cat.jpg"
      item.save
      user.image_items.last.should == item
      user.stream_items.last.streamable.should == item
    end
  end

  context "#last_twitter_item" do

    before do
      user.twitter_items.create :tweet => latest_tweet, :tweet_time => Time.now
      user.twitter_items.create :tweet => oldest_tweet, :tweet_time => 1.day.ago
    end

    subject { user.last_twitter_item }

    let(:latest_tweet) do
      { "id" => "latest tweet" }
    end

    let(:oldest_tweet) do
      { "id" => "oldest tweet" }
    end

    it "should return the last tweet" do
      subject.should_not be_nil
      subject.tweet.should eq latest_tweet
    end
  end

end
