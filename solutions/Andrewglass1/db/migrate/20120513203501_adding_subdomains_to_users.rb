class AddingSubdomainsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subdomain, :string
  end
end
