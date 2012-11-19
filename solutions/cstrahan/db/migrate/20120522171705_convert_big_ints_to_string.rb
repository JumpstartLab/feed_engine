class ConvertBigIntsToString < ActiveRecord::Migration
  def change
    remove_column :github_posts, :github_id
    remove_column :twitter_posts, :twitter_id
    remove_column :authentications, :last_status_id
    add_column :github_posts, :github_id, :string, limit: nil
    add_column :twitter_posts, :twitter_id, :string, limit: nil
    add_column :authentications, :last_status_id, :string, limit: nil
  end
end
