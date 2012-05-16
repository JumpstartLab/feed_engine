class AddExternalImageUrlToImagePostsTable < ActiveRecord::Migration
  def change
    add_column :image_posts, :external_image_url, :string
  end
end
