class UsersSwitchUsernameToDisplayName < ActiveRecord::Migration
  def change
    rename_column :users, :username, :display_name
  end
end
