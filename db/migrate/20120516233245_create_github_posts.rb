class CreateGithubPosts < ActiveRecord::Migration
  def change
    create_table :github_posts do |t|
      t.integer :github_id
      t.datetime :published_at
      t.string :repo_name
      t.string :repo_url
      t.string :type
      t.timestamps 
    end
  end
end
