class ChangeTwitterIdToString < ActiveRecord::Migration
  def change
    change_column :twitter_posts, :twitter_id, :string
  end
end
