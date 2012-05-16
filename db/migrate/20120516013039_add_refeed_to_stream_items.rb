class AddRefeedToStreamItems < ActiveRecord::Migration
  def change
    add_column :stream_items, :refeed, :boolean, :default => true
  end
end
