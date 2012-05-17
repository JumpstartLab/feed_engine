class SubscriptionsAddLastStatusIdToTable < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_status_id, :integer
  end
end
