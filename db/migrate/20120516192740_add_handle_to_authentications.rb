class AddHandleToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :handle, :string
  end
end
