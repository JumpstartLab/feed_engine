require 'spec_helper'

describe StreamItem do
  let(:post_types) { ["ImageItem", "LinkItem", "TextItem"] }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  before do
    10.times do
      item = FactoryGirl.create(:text_item, :user => user)
    end
    10.times do
      item = FactoryGirl.create(:image_item, :user => user)
    end
    10.times do
      item = FactoryGirl.create(:link_item, :user => user)
    end
  end

  context "when I try to add a stream item" do
    it "prevents the user from having multiple stream items to the same content" do
      item = user.stream_items.last.streamable

      stream_item = user.stream_items.new(streamable_id: item.id, streamable_type: item.class.name)
      stream_item.should_not be_valid
    end

    it "sets refeed to false for the original stream_item for a piece of content" do
      item = user.stream_items.last.streamable
      author_stream_item = item.stream_items.where(:user_id => item.user.id).first

      author_stream_item.refeed.should == false
    end

    it "prevents a second stream_item with refeed => false for a piece of content" do
      item = user.stream_items.last.streamable
      author_stream_item = item.stream_items.where(:user_id => item.user.id).first

      repeat_stream_item = user2.stream_items.new(streamable_id: item.id,
                                                  streamable_type: item.class.name,
                                                  refeed: false)

      repeat_stream_item.should_not be_valid
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
    end
  end
end
