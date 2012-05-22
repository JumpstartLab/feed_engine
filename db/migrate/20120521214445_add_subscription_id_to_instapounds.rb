class AddSubscriptionIdToInstapounds < ActiveRecord::Migration
  def change
    add_column :instapounds, :subscription_id, :integer
  end
end
