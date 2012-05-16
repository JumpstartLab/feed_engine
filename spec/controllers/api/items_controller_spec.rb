require 'spec_helper'

describe Api::ItemsController do
  it "tells me I'm unauthorized if I haven't authenticated" do
    get feed_item_index_path(user.display_name)
    "http://api.feedengine.com/feeds/hungryfeeder/items.json";
  end
end
