class SwitchExternalIdToString < ActiveRecord::Migration
  def change
    change_column :growls, :external_id, :string
  end
end
