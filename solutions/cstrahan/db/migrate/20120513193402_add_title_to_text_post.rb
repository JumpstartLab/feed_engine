class AddTitleToTextPost < ActiveRecord::Migration
  def change
    add_column :text_posts, :title, :string
  end
end
