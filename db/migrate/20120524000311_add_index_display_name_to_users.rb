class AddIndexDisplayNameToUsers < ActiveRecord::Migration
  def change
    add_index :users, :display_name
  end
end
