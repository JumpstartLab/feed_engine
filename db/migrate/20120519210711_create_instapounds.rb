class CreateInstapounds < ActiveRecord::Migration
  def change
    create_table :instapounds do |t|
      t.string  :image_url
      t.integer :poster_id
      t.string  :body

      t.timestamps
    end
  end
end
