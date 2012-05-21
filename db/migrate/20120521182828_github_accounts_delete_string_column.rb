class GithubAccountsDeleteStringColumn < ActiveRecord::Migration
  def change
    remove_column :github_accounts, :string
  end
end
