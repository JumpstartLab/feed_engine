class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :description
      t.text :url
      t.integer :poster_id

      t.timestamps
    end
    add_index :links, :poster_id
  end
end
