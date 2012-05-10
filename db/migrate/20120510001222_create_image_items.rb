class CreateImageItems < ActiveRecord::Migration
  def change
    create_table :image_items do |t|
      t.text :url
      t.string :comment
      t.timestamps
    end
  end
end
