class CreatePointGifts < ActiveRecord::Migration
  def change
    create_table :point_gifts do |t|
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
