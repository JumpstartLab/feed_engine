class AddSubscriptionIdToGithubEvents < ActiveRecord::Migration
  def change
    add_column :github_events, :subscription_id, :integer
  end
end
