class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :user_id
      t.integer :awardable_id
      t.string :awardable_type

      t.timestamps
    end
  end
end
