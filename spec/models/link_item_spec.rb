require 'spec_helper'

describe LinkItem do
  let(:link_item) { FactoryGirl.create(:link_item) }

  it "requires a url" do
    test_url = LinkItem.new(url: " ")
    test_url.should_not be_valid
  end

  it "requires a url less than 2049" do
    bad_url = "a" * 2049
    test_item = LinkItem.new(url:bad_url)
    test_item.should_not be_valid
  end

  it "requires a valid url" do
    bad_url = "adsbc" 
    test_item = LinkItem.new(url:bad_url)
    test_item.should_not be_valid
  end

  it "limits comment length to 256" do
    bad_comment = "a" * 257
    link_item.update_attributes(comment: bad_comment)
    link_item.should_not be_valid
  end

  it "allows proper comments" do
    good_comment = "a" * 250
    link_item.update_attributes(comment: good_comment)
    link_item.should be_valid
  end
end
