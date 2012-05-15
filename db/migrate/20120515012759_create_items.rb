class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :post, :polymorphic => true

      t.timestamps
    end
  end
end
