class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :poster_id
      t.references :post, :polymorphic => true

      t.timestamps
    end
  end
end
