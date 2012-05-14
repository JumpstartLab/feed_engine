class AddExternalIdToGrowl < ActiveRecord::Migration
  def change
    add_column :growls, :external_id, :integer
  end
end
