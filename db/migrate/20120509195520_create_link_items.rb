class CreateLinkItems < ActiveRecord::Migration
  def change
    create_table :link_items do |t|
      t.string :url
      t.text :comment
      t.references :user
      t.integer  :points_count, :default => 0
      t.timestamps
    end
  end
end
