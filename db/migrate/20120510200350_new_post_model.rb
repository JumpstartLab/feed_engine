class NewPostModel < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :post_type

      t.timestamps
    end
  end
end
