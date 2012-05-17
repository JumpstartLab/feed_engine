class RemovePointsFromPostTypes < ActiveRecord::Migration
  def change
    remove_column :image_posts, :points
    remove_column :text_posts, :points
    remove_column :link_posts, :points
  end
end
