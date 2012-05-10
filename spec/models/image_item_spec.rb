require 'spec_helper'

describe ImageItem do
  let(:image_item) { FactoryGirl.create(:image_item) }

  it "requires a url" do
    test_url = ImageItem.new(url: " ")
    test_url.should_not be_valid
  end

  it "requires a url less than 2049" do
    bad_url = "a" * 2049
    test_item = ImageItem.new(url:bad_url)
    test_item.should_not be_valid
  end

  it "requires a valid url" do
    bad_url = "adsbc" 
    test_item = ImageItem.new(url:bad_url)
    test_item.should_not be_valid
  end

  it "rejects a url ending without an image extension" do
    bad_url = "http://google.com" 
    test_item = ImageItem.new(url:bad_url)
    test_item.should_not be_valid
  end

  it "accepts a url ending with an image extension" do
    good_url = "http://google.com/image.png" 
    test_item = ImageItem.new(url:good_url)
    test_item.should be_valid
  end

  it "limits comment length to 256" do
    bad_comment = "a" * 257
    image_item.update_attributes(comment: bad_comment)
    image_item.should_not be_valid
  end

  it "allows proper comments" do
    good_comment = "a" * 250
    image_item.update_attributes(comment: good_comment)
    image_item.should be_valid
  end
end
