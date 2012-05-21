class AddUrlToImage < ActiveRecord::Migration
  def change
    add_column :images, :url, :text
  end
end