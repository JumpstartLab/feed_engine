class CreateMetaData < ActiveRecord::Migration
  def change
    create_table :meta_data do |t|
      t.string :title
      t.string :description
      t.string :thumbnail_url
      t.integer :growl_id

      t.timestamps
    end
  end
end
