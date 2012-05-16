class GrowlsTableRemoveColumnExternalId < ActiveRecord::Migration
  def change
    remove_column :growls, :external_id
    change_column :twitter_accounts, :last_status_id, :string, :null => false, :default => "0"
  end
end
