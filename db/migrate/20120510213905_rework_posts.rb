class ReworkPosts < ActiveRecord::Migration
  def up
    drop_table :posts
    create_table :posts do |t|
      t.integer :user_id
      t.integer :postable_id
      t.string :postable_type
    end
  end

  def down
    raise IrreversibleMigration
  end
end
