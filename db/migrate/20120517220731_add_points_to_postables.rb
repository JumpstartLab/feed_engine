class AddPointsToPostables < ActiveRecord::Migration
  def change
    add_column :messages, :points, :integer, :default => 0
    add_column :images, :points, :integer, :default => 0
    add_column :links, :points, :integer, :default => 0
    add_column :tweets, :points, :integer, :default => 0
    add_column :github_events, :points, :integer, :default => 0
  end
end
