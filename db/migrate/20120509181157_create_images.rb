class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :description
      t.text :url
      t.integer :poster_id

      t.timestamps
    end
    add_index :images, :poster_id
  end
end
