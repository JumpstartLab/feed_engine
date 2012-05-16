# == Schema Information
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  token      :string(255)
#  secret     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  uid        :string(255)
#

class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :token, :secret, :uid

  belongs_to :user
  after_create :import_items

  def create_with_omniauth(auth)
    self.update_attributes(provider: auth["provider"],
                           token: auth["credentials"]["token"],
                           secret: auth["credentials"]["secret"],
                           uid: auth["uid"])
    save!
  end

  def import_items
    Fetcher.import_items(self.provider, self.uid, self.user_id)
  end
end
