class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :user_id
      t.text :comment
      t.string :type
      t.text :content

      t.timestamps
    end
  end
end
