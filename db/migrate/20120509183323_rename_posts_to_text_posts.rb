class RenamePostsToTextPosts < ActiveRecord::Migration
  def change
    rename_table :posts, :text_posts
  end
end
