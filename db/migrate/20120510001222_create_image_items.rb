class CreateImageItems < ActiveRecord::Migration
  def change
    create_table :image_items do |t|
      t.string :url
      t.text :comment
      t.references :user
      t.timestamps
    end
  end
end
