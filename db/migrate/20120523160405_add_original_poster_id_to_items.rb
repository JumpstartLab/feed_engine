class AddOriginalPosterIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :original_poster_id, :integer
  end
end
