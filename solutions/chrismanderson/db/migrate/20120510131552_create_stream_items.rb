class CreateStreamItems < ActiveRecord::Migration
  def change
    create_table :stream_items do |t|
      t.references :user
      t.integer :streamable_id 
      t.string :streamable_type 
      t.integer  :points_count, :default => 0
      t.timestamps
    end
  end
end
