class AddHandleAndTweetTimeToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :handle, :string
    add_column :tweets, :post_time, :datetime
  end
end
