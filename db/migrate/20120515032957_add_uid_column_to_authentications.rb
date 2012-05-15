class AddUidColumnToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :uid, :string
  end
end
