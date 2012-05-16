class RegrowledFromId < ActiveRecord::Migration
  def change
    add_column :growls, :regrowled_from_id, :integer
  end
end
