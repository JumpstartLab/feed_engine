class AddRetroutedFromIdToStreamItems < ActiveRecord::Migration
  def change
    add_column :stream_items, :retrouted_from_id, :integer
  end
end
