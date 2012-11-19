class AddEventIdToGithubItems < ActiveRecord::Migration
  def change
    add_column :github_items, :event_id, :string
  end
end
