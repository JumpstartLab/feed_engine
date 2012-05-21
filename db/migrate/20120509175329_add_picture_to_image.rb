class AddPictureToImage < ActiveRecord::Migration
  def change
    add_column :images, :picture, :string
    add_column :images, :remote_picture_url, :string
  end
end
