require 'spec_helper'

describe LinkItem do
  let!(:user)     { FactoryGirl.create(:user)      }
  let(:link_item) { FactoryGirl.create(:link_item) }
  let(:good_url)   { "http://google.com/cat.html"}
  let(:long_url)   { "a" * 2049 }
  let(:malformed_url) { "abcd"}
  let(:bad_comment)   { "a" * 257 }
  let(:good_comment)  { "a" * 250 }


  it "requires a url" do
    test_url = LinkItem.new(url: " ", :user => user)
    test_url.should_not be_valid
  end

  it "requires a url less than 2049" do
    test_item = LinkItem.new(url:long_url, :user => user)
    test_item.should_not be_valid
  end

  it "requires a valid url" do
    test_item = LinkItem.new(url:malformed_url, :user => user)
    test_item.should_not be_valid
  end

  it "limits comment length to 256" do
    link_item = LinkItem.new(url: good_url, comment: bad_comment, :user => user)
    link_item.should_not be_valid
  end

  it "allows proper comments" do
    link_item = user.link_items.new(url: good_url, comment: good_comment)
    link_item.should be_valid
  end

  it "requires a user" do
    test_item = LinkItem.new(:url => good_url)
    test_item.should_not be_valid
  end

  it "adds the item to the author's feed" do
    test_item = LinkItem.new(:url => good_url, :user => user)
    test_item.save
    user.stream_items.last.streamable.should == test_item
    user.stream_items.last.refeed.should == false
  end

  context "#to_param" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:link_item) { FactoryGirl.create(:link_item, :user => user) }
    it "returns the id for the stream item between the post and its author" do
      link_item.to_param.should == link_item.stream_items.where(user_id: link_item.user_id).first.id
    end
  end
end
