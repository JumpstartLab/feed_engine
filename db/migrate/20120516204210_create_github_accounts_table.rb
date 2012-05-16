class CreateGithubAccountsTable < ActiveRecord::Migration
  def change
    create_table :github_accounts do |t|
      t.integer :authentication_id
      t.integer :uid
      t.string  :nickname
      t.string  :last_status_id, :string, :null => false, :default => "0"
      t.string  :image
      t.timestamps
    end
  end
end
