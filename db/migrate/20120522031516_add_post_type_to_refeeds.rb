class AddPostTypeToRefeeds < ActiveRecord::Migration
  def change
    add_column :refeeds, :post_type, :string
  end
end
