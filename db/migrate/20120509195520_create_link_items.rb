class CreateLinkItems < ActiveRecord::Migration
  def change
    create_table :link_items do |t|
      t.text :url
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
