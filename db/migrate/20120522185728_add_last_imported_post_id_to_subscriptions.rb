class AddLastImportedPostIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_imported_post_id, :integer
  end
end
