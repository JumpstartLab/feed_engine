require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  context "#add_stream_item" do
    it "adds a link item" do
    end
  end

  context "#new_stream_item_from_json" do
    it "returns a text_item for a request with type text_item" do
      body = '{"type":"TextItem","body": "I had some really good Chinese food for lunch today."}'
      parsed_json = JSON.parse(body)
      item = user.new_stream_item_from_json(parsed_json)
      item.should be_a(TextItem)
      item.body.should == "I had some really good Chinese food for lunch today."

      item.save
      user.text_items.last.should == item
    end

    it "returns a link_item for a request with type link_item" do
      body = '{"type":"LinkItem","comment": "I love Flash games.","link_url":"http://www.games.com/awesome.swf"}'
      parsed_json = JSON.parse(body)
      item = user.new_stream_item_from_json(parsed_json)

      item.should be_a(LinkItem)
      item.url.should == "http://www.games.com/awesome.swf"
      item.comment.should == "I love Flash games."
      user.link_items.last.should == item
    end

    it "returns an image_item for a request with type image_item" do
      body = '{"type":"ImageItem","comment": "This image is cool.", "image_url":"http://foo.com/cat.jpg"}'
      parsed_json = JSON.parse(body)

      item = user.new_stream_item_from_json(parsed_json)
      item.should be_a(ImageItem)
      item.comment.should == "This image is cool."
      item.url.should == "http://foo.com/cat.jpg"
      user.image_items.last.should == item
    end
  end
end
