class CreateBytes < ActiveRecord::Migration
  def change
    create_table :bytes do |t|
      t.string :type
      t.string :content

      t.timestamps
    end
  end
end
