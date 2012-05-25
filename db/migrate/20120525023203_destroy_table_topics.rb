class DestroyTableTopics < ActiveRecord::Migration
  def change
    drop_table :topics
  end
end
