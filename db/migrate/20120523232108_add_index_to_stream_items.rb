class AddIndexToStreamItems < ActiveRecord::Migration
  def change
    add_index :stream_items, [ :streamable_type, :streamable_id ]
  end
end
