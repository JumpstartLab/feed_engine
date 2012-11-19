class LazySusanForPosts < ActiveRecord::Migration
  def change
    add_index :posts, :id
    add_index :posts, :user_id
  end
end
