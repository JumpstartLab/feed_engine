class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :feed_id
      t.integer :postable_id
      t.string :postable_type
    end
  end
end
