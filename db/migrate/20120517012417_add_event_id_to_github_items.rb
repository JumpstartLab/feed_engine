class AddEventIdToGithubItems < ActiveRecord::Migration
  def change
    add_column :github_items, :event_id, :string
    remove_column :github_items, :gist
  end
end
