class AddLoginToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :login, :string
  end
end
