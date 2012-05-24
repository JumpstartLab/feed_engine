class AddAddedToPoint < ActiveRecord::Migration
  def change
    add_column :points, :added, :boolean
  end
end
