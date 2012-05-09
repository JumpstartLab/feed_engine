class UsersAddUsernameToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :display_name
    add_column :users, :username, :string
  end
end
