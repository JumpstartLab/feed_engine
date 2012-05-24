class RemovePointsFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :points
  end
end
