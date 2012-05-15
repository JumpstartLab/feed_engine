class AddPostTypeToItem < ActiveRecord::Migration
  def change
    add_column :items, :post_type, :string
  end
end
