class ConvertDescriptionInMetaDataToText < ActiveRecord::Migration
  def change
    change_column :meta_data, :description, :text
  end
end
