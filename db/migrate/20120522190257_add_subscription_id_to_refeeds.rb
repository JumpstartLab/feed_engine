class AddSubscriptionIdToRefeeds < ActiveRecord::Migration
  def change
    add_column :refeeds, :subscription_id, :integer
  end
end
