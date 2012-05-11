class AddTimestampToPost < ActiveRecord::Migration
  def change
    add_column :posts, :created_at, :timestamp
    add_column :posts, :updated_at, :timestamp
  end
end
