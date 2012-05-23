class AddUserIdToInstagramItems < ActiveRecord::Migration
  def change
    add_column :instagram_items, :user_id, :integer
  end
end
