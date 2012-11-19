class CreateGithubFeedItems < ActiveRecord::Migration
  def change
    create_table :github_feed_items do |t|
      t.string :content
      t.datetime :posted_at
      t.integer :user_id
      t.string :event_type
      t.integer :github_id

      t.timestamps
    end
  end
end
