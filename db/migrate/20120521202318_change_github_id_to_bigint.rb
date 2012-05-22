class ChangeGithubIdToBigint < ActiveRecord::Migration
  def change
    change_column :github_posts, :github_id, :integer, :limit => 8
  end
end
