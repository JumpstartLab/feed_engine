class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :content
      t.string :comment
      t.string :user_id
      t.timestamps
    end
    add_index :images, :user_id
  end
end
