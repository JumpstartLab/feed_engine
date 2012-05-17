class AddPosterIdToGithubEvents < ActiveRecord::Migration
  def change
    add_column :github_events, :poster_id, :integer
  end
end
