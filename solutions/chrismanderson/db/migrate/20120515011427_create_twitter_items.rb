class CreateTwitterItems < ActiveRecord::Migration
  def change
    create_table :twitter_items do |t|
      t.text :tweet
      t.references :user
      t.integer  :points_count, :default => 0
      t.timestamps
    end
    add_index :twitter_items, :user_id
  end
end
