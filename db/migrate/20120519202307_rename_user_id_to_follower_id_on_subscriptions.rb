class RenameUserIdToFollowerIdOnSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :user_id, :follower_id
  end
end
