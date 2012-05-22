class AddPosterIdToRefeeds < ActiveRecord::Migration
  def change
    add_column :refeeds, :poster_id, :integer
  end
end
