class AddPointsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :points, :integer, default: 0
  end
end
