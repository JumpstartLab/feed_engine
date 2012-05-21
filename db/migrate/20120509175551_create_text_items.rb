class CreateTextItems < ActiveRecord::Migration
  def change
    create_table :text_items do |t|
      t.text :body
      t.references :user
      t.timestamps
    end
  end
end
