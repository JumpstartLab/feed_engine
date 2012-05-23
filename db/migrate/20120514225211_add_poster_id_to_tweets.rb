class AddPosterIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :poster_id, :integer
  end
end
