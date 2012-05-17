class GrowlsRemoveRefeededFromUserId < ActiveRecord::Migration
  def change
    remove_column :growls, :refeeded_from_user_id
  end
end
