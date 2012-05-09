class GrowlsAddUserId < ActiveRecord::Migration
  def change
    add_column :growls, :user_id, :integer
  end
end
