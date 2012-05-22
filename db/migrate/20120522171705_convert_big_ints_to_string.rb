class ConvertBigIntsToString < ActiveRecord::Migration
  def change
    change_column :github_posts, :github_id, :string, limit: nil
    change_column :twitter_posts, :twitter_id, :string, limit: nil
    change_column :authentications, :last_status_id, :string, limit: nil
  end
end
