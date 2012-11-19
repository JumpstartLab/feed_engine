class CreateTwitterFeedItems < ActiveRecord::Migration
  def change
    create_table :twitter_feed_items do |t|
      t.text :content
      t.datetime :posted_at
      t.integer :user_id

      t.timestamps
    end
  end
end
