class CreateInstagramimages < ActiveRecord::Migration
  def change
    create_table :instagramimages do |t|
      t.string :content
      t.string :source_id
      t.string :handle
      t.datetime :post_time
      t.string :caption
      t.integer :user_id
      t.timestamps
    end
  end
end
