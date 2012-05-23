class AddRepoToGithubFeedItems < ActiveRecord::Migration
  def change
    add_column :github_feed_items, :repo, :string
  end
end
