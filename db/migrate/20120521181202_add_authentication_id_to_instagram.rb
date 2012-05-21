class AddAuthenticationIdToInstagram < ActiveRecord::Migration
  def change
    add_column :instagram_accounts, :authentication_id, :integer
  end
end
