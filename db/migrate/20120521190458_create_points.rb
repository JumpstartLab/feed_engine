class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
