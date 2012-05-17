class ChangeGithubEventBodyToRepo < ActiveRecord::Migration
  def change
    add_column :github_events, :repo, :string
    remove_column :github_events, :body, :string
  end
end
