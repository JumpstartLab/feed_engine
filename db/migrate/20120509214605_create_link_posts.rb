class CreateLinkPosts < ActiveRecord::Migration
  def change
    create_table :link_posts do |t|
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
