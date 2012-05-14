class Authentication < ActiveRecord::Base
  attr_accessible :user, :token, :secret, :provider
  belongs_to :user

  def self.twitter
    where(provider: "twitter").first
  end
end
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
#

