class AddTweetIdToTwitterItems < ActiveRecord::Migration
  def change
    add_column :twitter_items, :status_id, :string 
  end
end
