class AddFileToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :file, :string
  end
end
