class AddingUsernameToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :username, :string
  end
end
