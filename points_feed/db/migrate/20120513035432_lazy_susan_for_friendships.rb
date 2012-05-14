class LazySusanForFriendships < ActiveRecord::Migration
  def change
    add_index :friendships, :id
    add_index :friendships, :user_id
    add_index :friendships, :friend_id
    add_index :friendships, [:user_id, :friend_id]
    add_index :friendships, [:friend_id, :user_id]
  end
end
