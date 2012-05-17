class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :github_posts, :type, :github_type
  end

  def down
  end
end
