class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            null: false
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.string :display_name, null: false
      t.timestamps
    end
  end
end