class CreateImageItems < ActiveRecord::Migration
  def change
    create_table :image_items do |t|
      t.text :url
      t.text :comment
      t.timestamps
    end
  end
end
