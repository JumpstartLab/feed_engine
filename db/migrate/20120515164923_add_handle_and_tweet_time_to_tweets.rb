class AddHandleAndTweetTimeToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :handle, :string
    add_column :tweets, :tweet_time, :datetime
  end
end
