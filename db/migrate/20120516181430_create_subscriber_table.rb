class CreateSubscriberTable < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :subscriber_id
      t.timestamps
    end

    add_index :subscriptions, :user_id
    add_index :subscriptions, :subscriber_id
  end
end
