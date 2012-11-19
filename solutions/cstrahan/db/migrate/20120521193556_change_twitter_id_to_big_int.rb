class ChangeTwitterIdToBigInt < ActiveRecord::Migration
  def change
    remove_column :twitter_posts, :twitter_id
    add_column :twitter_posts, :twitter_id, :integer, :limit => 8
  end
end
