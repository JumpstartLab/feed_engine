class AddPointsToGrowls < ActiveRecord::Migration
  def change
    add_column :growls, :points, :integer, default: 0
  end
end
