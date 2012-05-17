require 'spec_helper'

describe ImageItem do
  let(:user)       { FactoryGirl.create(:user) }
  let(:image_item) { FactoryGirl.create(:image_item) }
  let(:good_url)   { "http://google.com/image.png" }
  let(:bad_format) { "http://google.com" }
  let(:bad_comment){"a" * 257}
  let(:long_url)   { "a" * 2049 }
  let(:blank_url)  { "" }
  let(:bad_url)    { "abcd" }

  it "requires a url" do
    test_item = ImageItem.new(url: blank_url)
    test_item.should_not be_valid
  end

  it "requires a url less than 2049" do
    test_item = ImageItem.new(url:long_url)
    test_item.should_not be_valid
  end

  it "requires a valid url" do
    test_item = ImageItem.new(url:bad_url)
    test_item.should_not be_valid
  end

  it "rejects a url ending without an image extension" do
    test_item = ImageItem.new(url:bad_format)
    test_item.should_not be_valid
  end

  it "accepts a url ending with an image extension" do
    test_item = ImageItem.new(url:good_url, :user => user)
    test_item.should be_valid
  end

  it "limits comment length to 256" do
    image_item.update_attributes(comment: bad_comment)
    image_item.should_not be_valid
  end

  it "allows proper comments" do
    good_comment = "a" * 250
    image_item.update_attributes(comment: good_comment)
    image_item.should be_valid
  end

  it "adds the item to the author's feed" do
    test_item = ImageItem.new(url: good_url, :user => user)
    test_item.save
    user.stream_items.last.streamable.should == test_item
    user.stream_items.last.refeed.should == false
  end

  context "#to_param" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:image_item) { FactoryGirl.create(:image_item, :user => user) }
    it "returns the id for the stream item between the post and its author" do
      image_item.to_param.should == image_item.stream_items.where(user_id: image_item.user_id).first.id
    end
  end
end
