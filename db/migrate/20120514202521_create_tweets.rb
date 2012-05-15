class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :subscription_id
      t.string :body

      t.timestamps
    end
  end
end
