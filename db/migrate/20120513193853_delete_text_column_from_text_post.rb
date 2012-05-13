class DeleteTextColumnFromTextPost < ActiveRecord::Migration
  def change
    remove_column :text_posts, :text
  end
end
