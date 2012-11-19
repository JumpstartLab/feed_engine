class AuthenticationsChangeLastStatusIdToString < ActiveRecord::Migration
  def change
    remove_column :authentications, :last_status_id
    add_column :authentications, :last_status_id, :string
  end
end
