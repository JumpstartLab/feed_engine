class CreateRefeeds < ActiveRecord::Migration
  def change
    create_table :refeeds do |t|
      t.integer :original_poster_id
      t.integer :refeeder_id
      t.integer :post_id

      t.timestamps
    end
  end
end
