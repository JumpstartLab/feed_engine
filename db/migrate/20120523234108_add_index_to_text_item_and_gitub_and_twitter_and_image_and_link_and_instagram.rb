class AddIndexToTextItemAndGitubAndTwitterAndImageAndLinkAndInstagram < ActiveRecord::Migration
  def change
    add_index :text_items, :user_id
    add_index :github_items, :user_id
    add_index :link_items, :user_id
    add_index :instagram_items, :user_id
    add_index :image_items, :user_id
  end
end
