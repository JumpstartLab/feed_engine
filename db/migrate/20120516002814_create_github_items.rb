class CreateGithubItems < ActiveRecord::Migration
  def change
    create_table :github_items do |t|
      t.text :activity

      t.timestamps
    end
  end
end
