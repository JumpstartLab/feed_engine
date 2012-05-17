class AddCommentToInstagramFeedItem < ActiveRecord::Migration
  def change
    add_column :instagram_feed_items, :comment, :string
  end
end
