class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.string :name
      t.string :link
      t.boolean :private, :default => false
      t.timestamps
    end
  end
end
