class AddOauthTokensToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :oauth_token, :string
    add_column :subscriptions, :oauth_secret, :string
  end
end
