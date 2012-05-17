class CreateGithubevents < ActiveRecord::Migration
  def change
    create_table :githubevents do |t|
      t.string :handle
      t.string :repo
      t.string :event_id
      t.string :action
      t.datetime :event_time
      t.integer :user_id
      t.text :content
      t.timestamps
    end
  end
end
