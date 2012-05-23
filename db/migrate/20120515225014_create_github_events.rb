class CreateGithubEvents < ActiveRecord::Migration
  def change
    create_table :github_events do |t|
      t.string :event_type
      t.string :body

      t.timestamps
    end
  end
end
