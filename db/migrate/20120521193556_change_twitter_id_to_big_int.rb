class ChangeTwitterIdToBigInt < ActiveRecord::Migration
  def change
    change_column :twitter_posts, :twitter_id, :integer, :limit => 8
  end
end
