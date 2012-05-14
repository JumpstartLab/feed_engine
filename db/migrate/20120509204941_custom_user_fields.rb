class CustomUserFields < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :full_name, :string
  end
end
