class AddCommentToLinks < ActiveRecord::Migration
  def change
    add_column :links, :comment, :string
  end
end
