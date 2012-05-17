class ChangeUrlForLinkAndImageItem < ActiveRecord::Migration
  def change
    change_column :image_items, :url, :text, :limit => nil
    change_column :link_items, :url, :text, :limit => nil
  end
end

