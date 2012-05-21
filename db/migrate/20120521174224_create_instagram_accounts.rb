class CreateInstagramAccounts < ActiveRecord::Migration
  def change
    create_table :instagram_accounts do |t|
      t.string :uid
      t.string :nickname
      t.string :image
      t.datetime :last_status_id

      t.timestamps
    end
  end
end
