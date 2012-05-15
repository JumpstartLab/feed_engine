class CreateLinkItems < ActiveRecord::Migration
  def change
    create_table :link_items do |t|
      t.text :url
      t.text :comment
      t.references :user
      t.timestamps
    end
  end
end
