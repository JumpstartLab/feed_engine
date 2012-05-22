class AddDetailsToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :last_status_id, :integer, :limit => 8
    add_column :authentications, :image, :string
  end
end
