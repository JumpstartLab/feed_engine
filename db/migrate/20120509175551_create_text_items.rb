class CreateTextItems < ActiveRecord::Migration
  def change
    create_table :text_items do |t|
      t.string :body
      t.timestamps
    end
  end
end
