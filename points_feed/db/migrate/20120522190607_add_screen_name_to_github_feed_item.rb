class AddScreenNameToGithubFeedItem < ActiveRecord::Migration
  def change
    add_column :github_feed_items, :screen_name, :string
  end
end
