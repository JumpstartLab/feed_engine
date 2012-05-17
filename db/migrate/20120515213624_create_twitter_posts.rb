class CreateTwitterPosts < ActiveRecord::Migration
  def change
    create_table :twitter_posts do |t|
      t.integer :twitter_id
      t.string :text
      t.timestamp :published_at

      t.timestamps
    end
  end
end
