class SubscriptionsAddLastStatusIdToTable < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_status_id, :integer

    add_column :growls, :refeeded_from_user_id, :integer
  end
end
