class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :content
      t.text :source_id
      t.integer :user_id
      t.timestamps
    end
  end
end
