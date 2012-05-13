class AddBodyToTextPost < ActiveRecord::Migration
  def change
    add_column :text_posts, :body, :text
  end
end
