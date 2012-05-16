class CreateRegrowls < ActiveRecord::Migration
  def change
    create_table :regrowls do |t|
      t.integer :user_id
      t.integer :growl_id

      t.timestamps
    end
  end
end
