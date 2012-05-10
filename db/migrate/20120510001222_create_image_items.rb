class CreateImageItems < ActiveRecord::Migration
  def change
    create_table :image_items do |t|
      t.string :url
      t.string :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
