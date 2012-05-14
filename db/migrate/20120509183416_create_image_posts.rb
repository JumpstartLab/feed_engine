class CreateImagePosts < ActiveRecord::Migration
  def change
    create_table :image_posts do |t|
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
