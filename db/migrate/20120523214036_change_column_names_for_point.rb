class ChangeColumnNamesForPoint < ActiveRecord::Migration
  def change
    rename_column :points, :user_id, :receiver_id
    add_column :points, :giver_id, :integer
  end
end
