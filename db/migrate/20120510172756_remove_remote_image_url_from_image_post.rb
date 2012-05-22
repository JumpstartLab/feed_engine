class RemoveRemoteImageUrlFromImagePost < ActiveRecord::Migration
  def change
    remove_column :image_posts, :remote_image_url
  end
end
