require 'spec_helper'

describe GithubItem do
  let(:item) {InstagramItem.create}
  let!(:image) { JSON.parse'{"images":{"standard_resolution":{"url":"http://trout.com/trout.jpg"}},
                             "caption":{"text":"sweet caption"},
                             "repo":{"name":"sweet_repo"}}' }

  before { item.image = image }
  context "#image_url" do
    it "returns a url if provided" do
      item.image_url.should == "http://trout.com/trout.jpg"
    end

    it "returns empty string otherwise" do
      item.image = {}
      item.image_url.should == ""
    end
  end

  context "#caption" do
    it "returns a caption if provided" do
      item.caption.should == "sweet caption"
    end
    it "returns an empty_string otherwise" do
      item.image = {}
      item.caption.should == ""
    end
  end

  context ".create_from_json" do
    it "creates a new instagram_item" do
      image = JSON.parse('{"image":{"id":"1","images":{"standard_resolution":{"url":"http://trout.com/trout.jpg"}},
                         "caption":{"text":"sweet caption"},
                         "repo":{"name":"sweet_repo"}}}')
      item = InstagramItem.create_from_json(1, image)
      item.image_url.should == "http://trout.com/trout.jpg"
    end
  end

end
