class CreateInstagramFeedItems < ActiveRecord::Migration
  def change
    create_table :instagram_feed_items do |t|
      t.string :image_url
      t.datetime :posted_at
      t.integer :user_id
      t.string :instagram_id
      t.timestamps
    end
  end
end
