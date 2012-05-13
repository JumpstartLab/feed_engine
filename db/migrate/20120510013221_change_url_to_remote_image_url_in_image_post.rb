class ChangeUrlToRemoteImageUrlInImagePost < ActiveRecord::Migration
  def change
    rename_column :image_posts, :url, :remote_image_url
  end
end
