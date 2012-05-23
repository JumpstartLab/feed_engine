class AddLastPostIdToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :last_post_id, :integer
  end
end
