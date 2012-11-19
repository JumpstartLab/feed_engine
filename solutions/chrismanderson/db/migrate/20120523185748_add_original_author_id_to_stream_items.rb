class AddOriginalAuthorIdToStreamItems < ActiveRecord::Migration
  def change
    add_column :stream_items, :original_author_id, :integer
  end
end
