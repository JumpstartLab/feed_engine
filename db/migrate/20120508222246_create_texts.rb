class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :content
      t.integer :user_id
      t.timestamps
    end
    add_index :texts, :user_id
  end
end
