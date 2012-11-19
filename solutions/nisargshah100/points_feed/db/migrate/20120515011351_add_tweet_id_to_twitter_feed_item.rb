class AddTweetIdToTwitterFeedItem < ActiveRecord::Migration
  def change
    add_column :twitter_feed_items, :tweet_id, :integer
  end
end
