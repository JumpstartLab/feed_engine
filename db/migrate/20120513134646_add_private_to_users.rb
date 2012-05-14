class AddPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private, :boolean, default: false
  end
end
