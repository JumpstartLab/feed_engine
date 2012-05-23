class CreateInstagramItems < ActiveRecord::Migration
  def change
    create_table :instagram_items do |t|
      t.text :image
      t.string :image_id

      t.timestamps
    end
  end
end
