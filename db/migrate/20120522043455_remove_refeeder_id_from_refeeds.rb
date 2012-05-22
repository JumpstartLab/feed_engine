class RemoveRefeederIdFromRefeeds < ActiveRecord::Migration
  def change
    remove_column :refeeds, :refeeder_id
  end
end
