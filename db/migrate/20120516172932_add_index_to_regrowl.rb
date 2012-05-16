class AddIndexToRegrowl < ActiveRecord::Migration
  def change
    add_index(:regrowls, [:user_id, :growl_id], :unique => true)
  end
end
