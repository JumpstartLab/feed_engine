class DontUseFuckingStringsForTextLongerThan255CharactersDawg < ActiveRecord::Migration
  def change
    change_column :images, :remote_picture_url, :text
  end
end
