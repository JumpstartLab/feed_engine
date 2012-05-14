class MetaDataNoLimitOnDescription < ActiveRecord::Migration
  def change
    change_column :meta_data, :description, :text, limit: nil
  end
end
