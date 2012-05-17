class MoveRefeedIdToPostsTable < ActiveRecord::Migration
  def change
    remove_column :image_posts, :refeed_id
    remove_column :text_posts,  :refeed_id
    remove_column :link_posts,  :refeed_id

    add_column :posts, :refeed_id, :integer
  end
end
