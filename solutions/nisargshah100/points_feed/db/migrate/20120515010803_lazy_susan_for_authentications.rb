class LazySusanForAuthentications < ActiveRecord::Migration
  def change
    add_index :authentications, :id
    add_index :authentications, :user_id
    add_index :twitter_feed_items, :id
    add_index :twitter_feed_items, :user_id
  end
end
