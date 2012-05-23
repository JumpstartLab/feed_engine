class AddRefeedToItem < ActiveRecord::Migration
  def change
    add_column :items, :refeed, :boolean
  end
end
