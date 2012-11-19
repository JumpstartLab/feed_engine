class AddScreenNameToTwitterFeedItem < ActiveRecord::Migration
  def change
    add_column :twitter_feed_items, :screen_name, :string
  end
end
