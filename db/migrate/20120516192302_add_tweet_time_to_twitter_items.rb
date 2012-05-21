class AddTweetTimeToTwitterItems < ActiveRecord::Migration
  def change
    add_column :twitter_items, :tweet_time, :datetime
  end
end
