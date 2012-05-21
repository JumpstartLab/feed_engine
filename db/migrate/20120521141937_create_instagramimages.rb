class CreateInstagramimages < ActiveRecord::Migration
  def change
    create_table :instagramimages do |t|
      t.string :content
      t.string :source_id
      t.string :handle
      t.string :post_time
      t.string :caption
      t.timestamps
    end
  end
end
