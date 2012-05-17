class AddGithubColumnsToGrowls < ActiveRecord::Migration
  def change
    add_column :growls, :original_created_at, :datetime
    add_column :growls, :event_type, :string
  end
end
