class AddAttachmentPhotoToGrowls < ActiveRecord::Migration
  def self.up
    add_column :growls, :photo_file_name, :string
    add_column :growls, :photo_content_type, :string
    add_column :growls, :photo_file_size, :integer
    add_column :growls, :photo_updated_at, :datetime
  end

  def self.down
    remove_column :growls, :photo_file_name
    remove_column :growls, :photo_content_type
    remove_column :growls, :photo_file_size
    remove_column :growls, :photo_updated_at
  end
end
