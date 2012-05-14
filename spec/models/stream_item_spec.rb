require 'spec_helper'

describe StreamItem do
  let(:post_types) { ["ImageItem", "LinkItem", "TextItem"] }
  let!(:user) { FactoryGirl.create(:user) }
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
  end

  context ".translate_batch" do
    it "returns a set of posts given a set of stream_items" do
      posts = StreamItem.translate_batch(user.stream_items.all)
      posts.each do |post|
        post_types.should include(post.class.name)
      end
    end
  end

  context ".translate_item" do
    it "returns a post given a stream_item" do
      post = StreamItem.translate_item(user.stream_items.last)
      post_types.should include(post.class.name)
    end
  end
end
