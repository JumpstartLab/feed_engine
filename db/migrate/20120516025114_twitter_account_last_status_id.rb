class TwitterAccountLastStatusId < ActiveRecord::Migration
  def change
    rename_column :twitter_accounts, :initial_status, :last_status_id
  end
end
