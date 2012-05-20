class ChangeSubscriptionForeignKeyName < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :author_id, :followed_user_id
  end
end
