class AddPointsToInstapounds < ActiveRecord::Migration
  def change
    add_column :instapounds, :points, :integer, :default => 0
  end
end
