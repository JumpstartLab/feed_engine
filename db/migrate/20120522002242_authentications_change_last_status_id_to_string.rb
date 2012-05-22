class AuthenticationsChangeLastStatusIdToString < ActiveRecord::Migration
  def change
    change_column :authentications, :last_status_id, :string
  end
end
