class AddGrowlsTable < ActiveRecord::Migration
  def change
    create_table :growls do |t|
      t.string :type
      t.text :comment
      t.text :link

      t.timestamps
    end
  end
end