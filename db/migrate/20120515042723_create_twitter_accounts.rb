class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer :authentication_id
      t.integer :uid
      t.string  :nickname
      t.string  :initial_status
      t.string  :image
      t.timestamps
    end
  end
end
