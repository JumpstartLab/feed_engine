require 'spec_helper'

describe "API /feeds/<feedname>", :type => :api do
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

  context "getting the user's feed items" do
    let(:url) { api_stream_path(user) }

    it "returns an array of json" do
    end
  end
end
