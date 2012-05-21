class InstagramAccountsChangeLastStatusIdToString < ActiveRecord::Migration
  def change
    change_column :instagram_accounts, :last_status_id, :string
  end
end
