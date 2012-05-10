class AddFeedTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :feed_id, :integer
    rename_column :posts, :post_type, :feed_type
  end
end
