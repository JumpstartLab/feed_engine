class AddRefeedIdToAllTheThings < ActiveRecord::Migration
  def change
    add_column :image_posts, :refeed_id, :integer
    add_column :link_posts,  :refeed_id, :integer
    add_column :text_posts,  :refeed_id, :integer
  end
end
