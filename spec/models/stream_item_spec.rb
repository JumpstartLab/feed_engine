require 'spec_helper'

describe StreamItem do
  let(:post_types) { ["ImageItem", "LinkItem", "TextItem"] }
  let!(:user) { FactoryGirl.create(:user) }
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
