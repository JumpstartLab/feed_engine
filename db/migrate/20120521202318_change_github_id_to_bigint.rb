class ChangeGithubIdToBigint < ActiveRecord::Migration
  def change
    remove_column :github_posts, :github_id
    add_column :github_posts, :github_id, :integer, :limit => 8
  end
end
