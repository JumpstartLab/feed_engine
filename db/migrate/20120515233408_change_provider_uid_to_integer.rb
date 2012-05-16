class ChangeProviderUidToInteger < ActiveRecord::Migration
  def change
    change_column :authentications, :uid, :integer
  end
end
