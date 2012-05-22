class AddInstagramPostTable < ActiveRecord::Migration
  def change
    create_table :instagram_posts do |t|
      t.string :instagram_id, null: false
      t.string :url
      t.integer :refeed_id

      t.timestamps
    end
  end
end
