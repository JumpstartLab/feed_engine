class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :content
      t.string :user_id
      t.timestamps
    end
    add_index :links, :user_id
  end
end
